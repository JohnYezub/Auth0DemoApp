//
//  Auth0DemoAppTests.swift
//  Auth0DemoAppTests
//
//  Created by Yevgeny Yezub on 22/11/22.
//

import XCTest
@testable import  Auth0DemoApp

final class Auth0DemoAppTests: XCTestCase {

    private var authViewModel: AuthViewModel?

    override func setUpWithError() throws {
        authViewModel = AuthViewModel(authService: AuthService.Mocked())
    }

    override func tearDownWithError() throws {
        authViewModel = nil
    }

    func testAuthScreenIsSignUp() throws {
        authViewModel?.toggleAuthScreen()
        XCTAssertFalse(authViewModel?.accessType == .login)
    }

    func testAuthScreenIsLogin() throws {
        XCTAssert(authViewModel?.accessType == .login)
    }

    func testErrorIsExist() throws {
        authViewModel?.getAuthorized()
        XCTAssert(authViewModel?.errorText != nil)
    }

    //TODO: add more tests
}

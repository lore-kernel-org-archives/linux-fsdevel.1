Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724866;
	b=lzeudaCR5hjLBQudQsLso5GVV1GAZvCCNrd2zd6hmJ3kIw6ArVDYv+24113UNs2HDmVE
	 XBReI+2bV71VFt8uYbKihe9HY73PlgJwHP5KPDa/NONugM/gZweoQe+S5lL/mX6T/mfjR
	 74vdurh+d9YNANwwLoaRCrGFbum5dFV331OOq0VNXCJwY/9CYqX/sfm7rGG6uKyRT+/eX
	 E7TP6l67fNo9uPypBmlLBeBUJ/TiD0UInAE4bE9XeelGXDidBqSsIoi0hBoDv7CUpga3N
	 OjnU46cxLTEA32LM7vZDSi9s1q0jwDgxq+bS8gjVvIDsZ7/He7+87xpJNPpiNxIlPlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724866;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9E8O4GJrrDPUZq5FZkBH34WVGX8r7ZAAIL0omDrXCko=;
	b=kxrH+54lIIJh5Wc5QtAji6JscrAjwU51CpaLzyZNZFZm5NiF61xYbgJ+ExY7pZ0eL7r4
	 13gj7q8JUPFc6KxgLb7JxtpqNEodGqJuWFz8/tSkG08iY7+5KAFTQBYzU5/nh1qkSg1YQ
	 WFCIDJsXGQvrpGRZ7jLOvVPimVenqG59rdxp1M+20onF6NnqKGuPN25ZAP2KCWi0TqlL8
	 wxJvSvrwvIe7s8B/pN/ND0ITj5bSX0bID0o6q5OQVz+XHooW6UElYv+5QStRylmciL7on
	 VCsZu14yM1w4YiDwdfEmXFZ3mgO58Eulp3UNUcWz5hFJUrickR26srxALI+Q5UZv/dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVGT3Kyf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AB606D818;
	Tue,  3 Nov 2026 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVGT3Kyf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0601F00A18;
	Tue,  3 Nov 2026 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724865;
	bh=9E8O4GJrrDPUZq5FZkBH34WVGX8r7ZAAIL0omDrXCko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OVGT3KyfSO7lz698T/7ZIH19zf/F71nm3PVqZxgHe3otI7z1Z2q9m/VOYj/7pHpU9
	 A+vRPIriUmHo66gIO2miB288wqxkXmUJbIRy8Yy15XJqT54ZmP7/POqwbgWJm5l3lM
	 2KsxVrZWx2MVRPl4j6DYL+Cgv6S7f28clNz2KhBm8STmkzFaBRKfW0bqYgF+htRXoY
	 K0aDYHa+zNYI+6Wxpu4BMSuFhsegU98toErDlTwr/gCqjExv55vx7Dlorqqzcy/hyv
	 s4CaUL+QBHrtCbJzyXzLjXNX53gosClI/vn+ccD7x8uZ/nC/hZ+HgcD4P+Zbc/1r+E
	 58HROTINW5O7Q==
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/namespaces: initialize the byte the children write
Date: Tue,  3 Nov 2026 11:54:17 -0500
Message-ID: <20261103165419.687806-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103165419.687806-1-sashal@kernel.org>
References: <20261103165419.687806-1-sashal@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The children in listns_pagination_bug and stress_test write c to the
parent only to say they are ready, but never set it, and clang 21
warns:

  stress_test.c:137:22: warning: variable 'c' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]

Initialize it to 'X', as the parent does with its byte.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with clang 21. The namespaces tests aren't in TARGETS in
tools/testing/selftests/Makefile, so CI doesn't build or run them. Is
that on purpose?

 tools/testing/selftests/namespaces/listns_pagination_bug.c | 2 +-
 tools/testing/selftests/namespaces/stress_test.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/namespaces/listns_pagination_bug.c b/tools/testing/selftests/namespaces/listns_pagination_bug.c
index da7d33f963972..6452825e88506 100644
--- a/tools/testing/selftests/namespaces/listns_pagination_bug.c
+++ b/tools/testing/selftests/namespaces/listns_pagination_bug.c
@@ -46,7 +46,7 @@ TEST(pagination_with_type_filter)
 		ASSERT_GE(pids[i], 0);
 
 		if (pids[i] == 0) {
-			char c;
+			char c = 'X';
 			close(sv[0]);
 
 			if (setup_userns() < 0) {
diff --git a/tools/testing/selftests/namespaces/stress_test.c b/tools/testing/selftests/namespaces/stress_test.c
index dd7df7d6cb277..6a27b98c5bc2a 100644
--- a/tools/testing/selftests/namespaces/stress_test.c
+++ b/tools/testing/selftests/namespaces/stress_test.c
@@ -124,7 +124,7 @@ TEST(many_concurrent_namespaces)
 
 		if (pids[i] == 0) {
 			/* Child: create user namespace and wait for parent signal */
-			char c;
+			char c = 'X';
 
 			close(sv[0]);
 
@@ -366,7 +366,7 @@ TEST(listns_pagination_stress)
 		ASSERT_GE(pids[i], 0);
 
 		if (pids[i] == 0) {
-			char c;
+			char c = 'X';
 			close(sv[0]);
 
 			if (setup_userns() < 0) {
-- 
2.53.0


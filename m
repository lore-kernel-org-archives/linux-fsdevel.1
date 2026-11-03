Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724864;
	b=B/tRNBXwPKFPJBQWo5pa+rb+qaO4OEx8hktMcajlCXVTLmtgZO0UBRXEGNnqw3MEQDeN
	 cTSRxifGMUrP0j4QP2B4y92R2rxz5BjaWn581BRAdNySI3J0wwoGe8lXBPo4CTiFU2GUn
	 YD1QcX/r5gNR/gJQBGqnPQrfGv9XBhmQYpvdBbqobU+PolZ4Oj2pzxTaKrYrkCPIbpA1W
	 3E7WnuK9H5BPDW79Zngjfd75V9PYpWEgu/968EL715l75fvv1XRBH08kQhgA//UiHa5ro
	 F6cqRwQP4mUTEyyooFKndq+sVyO+3c9u2W0pQ8sGNn4IsdQL+8IdTyyqFP0BTQj8dYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BO9yWe9+fm0iGnEuM044aDt+rOd0k8gYRPiRL6nVn4A=;
	b=c7JCmWUwXHk6UOaxpFJKrw5i+8XMHoKta+ds6xCMx7rX753T2BpWyQCMoZFnr79HTmbI
	 BytjtpTJKGXvPfFAS4vrX+AAs9ZraNN+qMoXj+ijXuKIINT7LvuFK3QCHpbhXbQck8sZK
	 W9/kB/wQ4o+8qUkOSIDrx6d+1zNJ8mWCjBmyASUpd17a3NT/oRjT/GwD6Ql0SnM447fZD
	 STCaSypqbHOP+4GuoGgDI7flCZDxZ2pakqMh8S6DzpWrQl48IAbMNwW+Yu9z//CZ6ZRaE
	 lUmY/bWf4G/kKT9foexEvlhrPpUuisMgquR5wnD3MMsEw6sdShHRBgjMG0lRI/g7LTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBFObwWD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB04606D803;
	Tue,  3 Nov 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBFObwWD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864AB1F00A1B;
	Tue,  3 Nov 2026 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724864;
	bh=BO9yWe9+fm0iGnEuM044aDt+rOd0k8gYRPiRL6nVn4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UBFObwWD0VfKcfxCA+u+yoSkVp3ZMS4OHkUMKtKund5QJdjVRxL0HAKkFNsA5+ukE
	 OEhjjcWBfy7R5MKFZ4OYvooyNDEBywsNiCYRqPDozlvJG9HnxWqGviD+JQocNG0QGT
	 GExlwZ4LTFT1NG5r6FTfmowSD+gsP7oVZ43HTQLcksXKcxwikcnaN2UJIpSblAxMYu
	 zuIn8E93+yViw2vxyC4KraAX9sS8c7OGBC2w5GT4qqmlnSPXFdyXJUFrUccbkoQPjj
	 pqUFA4oHkdhmGINaucU7ck9p4pE5SFvo9BHAjdmb4KyBrmU6jhNJ+s7HN2ZkR9SlDz
	 DgLcSJiAkNOyQ==
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/statmount: initialize the byte written to the child
Date: Tue,  3 Nov 2026 11:54:16 -0500
Message-ID: <20261103165419.687806-3-sashal@kernel.org>
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

test_listmount_ns() writes pval to the child only to let it exit, but
never sets it, and clang 21 warns:

  statmount_test_ns.c:334:35: warning: variable 'pval' is uninitialized when passed as a const pointer argument here [-Wuninitialized-const-pointer]

Initialize it to 0.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with clang 21; KernelCI's clang builds show the same warning.

 .../testing/selftests/filesystems/statmount/statmount_test_ns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
index e500905e4c078..e7261d4f3be4e 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
@@ -275,7 +275,7 @@ static int validate_external_listmount(pid_t pid, uint64_t child_nr_mounts)
 static void test_listmount_ns(void)
 {
 	uint64_t nr_mounts;
-	char pval;
+	char pval = 0;
 	int child_ready_pipe[2];
 	int parent_ready_pipe[2];
 	pid_t pid;
-- 
2.53.0


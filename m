Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583234;
	b=HvFCGjQ+sL6uTQ4ECk8S3CKsX6vdrFcJ4hQr69iOYaceTbxG8WNfg779d6x886oubdmF
	 O6iLqd8tilgLTfi6JWc13mDS6QJc0cY6h5apuuwSECltsX3xd52BE5rTCdTXRpmzQ1XSL
	 xrkKc0sbp261tbOWkFFQu6iBIup6RBmCGRDZljUJyq06Df9JMrR/8bN2WnnftqmqdWNqJ
	 Etkxn3y6+9U+TXvU50pStr28Gnt3Oa6GoP4GoLhTMjVfFPnnKZX+3rUUTSMKIPUs4u0Z/
	 FcI8PSWrqAJmQ5S1SVddT2Bm3aFHayO3Jx7uy4Q5t5TXy2Trd43cgh457/Hl6MDWntg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583234;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=p9dYZ4F9rlJcJCmJHQmhoHVJiIw7UG5SjWR8xpPAdug=;
	b=ZAh445qQyfdgmml9imizp58LMb7EQ3NuGBZd2G9UdJBOmNtcnezppj9LNEivVemGfiUS
	 WsvfHaB0mt5DKmtEMxUVbzlgulrxaoKh8h1/nKIGWpA8GIAfBnUtemZTWA6vK6FSThvj3
	 6DsvIvOoEj6WfyrCUiBABki5N3jmo3E0767Fso/xjlU4srUy4BdJhVT2brMODJfORWT+k
	 b86oEHWwFY4KhbZE/tWi7xqsO+jP0kdk44KfrfdZ3ZUfYNLzQNSLwS+JEc8St+zWMApq3
	 YmEqBL+KHZ0khmeQHTAC6QqaVZyDpZzG0lYQF0udAXWmiJqOwf1Asp2ZNFLCHKdc8MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsV2JvEP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE8606A320;
	Wed, 21 Oct 2026 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsV2JvEP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA141F000C5;
	Wed, 21 Oct 2026 11:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583234;
	bh=p9dYZ4F9rlJcJCmJHQmhoHVJiIw7UG5SjWR8xpPAdug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NsV2JvEP9ZqOBGONjfbCv+HNQq27qJ0E7SB1ZkV9Ry5MGIn/b40SqT9oRH73ClDNE
	 PhTM6156P2JkaqRm6puzUZqWkiSSFoq1VzuvEp9EDWxWJySVj+r5nzhHGh+ILJXprw
	 SZn+WIi3wiKQ7kbb4ohBV8og1Kc64xOitmc2Q3hsBPc1wqD2TxrCrUMKe4eMeCHZtb
	 xnlugAjLWw70rWkflL4CsgB5efYxDloNobYLdV/tDtj+TFH20oWfpf5ytxlFDlTjnd
	 L9cNHVRLyntqMvdSwd9LSPkjMKpTofvjtKxsJXV6uVVUVjNAD/DPE034qHkvjtUDM/
	 awsjEQNEB+KxA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Oct 2026 13:46:57 +0200
Subject: [PATCH 4/6] selftests/filesystems: check listmount() with a
 U64_MAX cursor
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-work-mount-statmount_listns_fixes-v1-4-8917a4c1bd14@kernel.org>
References: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <mszeredi@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=brauner@kernel.org;
 h=from:subject:message-id; bh=v2s01NuJ0gxPAL+XB47/cuWa8tpTQp1RNhAzdUP7HpY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdWGYsFRcqXbeBM8R775EcndOXlpVu0nRtcxM85X+5M
 OLvRdmCjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImkTGBk6LuyaqFm1v9bjybu
 8zlUvlacOe/GWV4O+Yg5B+oedfWEHWT4X/lcO4xJ8MsyF8Y6Qf5vsnsPz2Gb+XS2R/Wmuqm3r5h
 M5AAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pass the largest possible mount id as the cursor and check that
listmount() returns no entries instead of starting over at the first
mount.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../testing/selftests/filesystems/statmount/listmount_test.c  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/filesystems/statmount/listmount_test.c b/tools/testing/selftests/filesystems/statmount/listmount_test.c
index 8bc82f38c42f..e603525ce17b 100644
--- a/tools/testing/selftests/filesystems/statmount/listmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/listmount_test.c
@@ -63,4 +63,15 @@ TEST(listmount_backward)
 	}
 }
 
+/* A cursor at the largest possible mount id must not wrap around. */
+TEST(listmount_cursor_max)
+{
+	uint64_t list[LISTMNT_BUFFER];
+	ssize_t nr_mounts;
+
+	nr_mounts = listmount(LSMT_ROOT, 0, UINT64_MAX, list,
+			      LISTMNT_BUFFER, 0);
+	ASSERT_EQ(nr_mounts, 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0


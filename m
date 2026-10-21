Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583239;
	b=ruB4okbhImwm0NVCO//zOUfzuJE279gzv2FwdJx+KYd9wCCh0QzNS1A4l0mGUEhHfQV8
	 cUSzi09CPjQzCdE23xflypsGIPwiPNYTSJdD/3KvVRHgMt75iBVR6jpfFA1tjeGDNhh5Y
	 ti+an18osyV7qfswBhJtAvbHSbxSrvLAsRhg20mOzbcw+UXcYYWiiKR6RCZm4ZIz464xu
	 d6mjN8ObDjYnfrbTEDT11C5TbVgY01/6bwlzbKVLkUZ5IOz3uUF8AfKU4DpH3LHZ++est
	 VlnBbXTAn3hzsxrtDjyrF9Y8S1o2XIuUrXPhvg5R2NWmw7yQP3S1R7DteKsAH2c/4rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583239;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZK1UDYqlrE5I3QSf/kmKoT1S2Bpfw8AVdTWbazUWD2E=;
	b=gy40GBmXRs+eVaNK8AVuJnnJQ9fRPyFMlXZ2nGG2BLwavgHJQ4hE9KYcNMMFHa4eyulk
	 DYkbuuBPb6azUPEZP/VV/bUsNNNxd0WLRXKvpanvUxsQMVV+PQtSyml6GbTohVs8GZjWW
	 gS3cKpRmH/RPoYNfUs9vwr1P3J0avXOAbuswmca7PN2sj+IF+xtUUMT0NUt9IliO3Nh2I
	 Jvd7hA/vF0mnz8hA2N45AR4W37qtcLrs/5sbm3/cSosTnuytJzN6RJdVrw/y6W0KkiACy
	 vInJoZYPZCsMNz8Io1Ue70noYO7JTmhiYGvJx4u9obWt/KYgGxDOqJS+FeQ/EUalJsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHOTcJJT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F505606A31A;
	Wed, 21 Oct 2026 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHOTcJJT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222CC1F000CB;
	Wed, 21 Oct 2026 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583238;
	bh=ZK1UDYqlrE5I3QSf/kmKoT1S2Bpfw8AVdTWbazUWD2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kHOTcJJTTvmPimRYnyI6Pebb+yrudWTsKskuhoO3Nkp9Swdgz/3pRu3F1eo0+HpCu
	 ocTdn6Yt94zWLvEPEDqDM9X0LUAFZrnLxVqUh+c280Cjsixlr4D9FAtXw1TD2zHRY+
	 sDZPs0UvsOdzRrDTz78deZouLLu/TgLtiIUKMeK2+f8U8n8FMvrsiRvbgt1sQ9IUQz
	 12FEvqya7vTyYOamIeiB1kwnPfZNnGR0FzcyBYm/f6w6ABQ8RQhCGt9B4wZDamXUy+
	 LWzBPXBLf7D3/3i3/PldBE6mnzFMbW67DL4XIokUNVXG8PQbLccVoW6rGUAimQ3QVB
	 uuXi83jRo4h7Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Oct 2026 13:46:59 +0200
Subject: [PATCH 6/6] selftests/namespaces: check listns() with a U64_MAX
 cursor
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
Message-Id: <20261021-work-mount-statmount_listns_fixes-v1-6-8917a4c1bd14@kernel.org>
References: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
In-Reply-To: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <mszeredi@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ewb+3asdWxj/HiYTZDYGPtWBMPvcZEbR01MtLm5wUa0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdWGZyf0aE+cn13bP143Tdq5/3FnzKXxFzaMUxPsOPH
 95NeRgU31HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARL06GX8zXN854b7Z5tXRF
 z2X51pncUpvTWWc5ab1dM++UnXFw2nmG/+lhH0+8/zFNgVtF5dEpt8P7uot99+z4+VMyceFV3ks
 Bt3gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Pass the largest possible namespace id as the cursor and check that
listns() fails with ENOENT instead of starting over:

- in the unified tree

- in a type-specific tree

- in the owner tree of the caller's user namespace

Nothing can come after the largest possible id.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index 8a95789d6a87..538d60f908b4 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -676,4 +676,38 @@ TEST(listns_error_cases)
 	}
 }
 
+/*
+ * A cursor at the largest possible namespace id must not wrap around and
+ * restart the listing from the beginning.
+ */
+TEST(listns_cursor_max)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.ns_id = ULLONG_MAX,
+	};
+	__u64 ns_ids[10];
+	ssize_t ret;
+
+	/* unified tree */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0 && errno == ENOSYS)
+		SKIP(return, "listns() not supported");
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ENOENT);
+
+	/* type-specific tree */
+	req.ns_type = CLONE_NEWUSER;
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ENOENT);
+
+	/* owner tree */
+	req.ns_type = 0;
+	req.user_ns_id = LISTNS_CURRENT_USER;
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ENOENT);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0


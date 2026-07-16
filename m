Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD31481B1;
	Thu, 16 Jul 2026 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170042; cv=none; b=HLVLTueTWrZvANdvdC/ilVYExycCLbzyion6z6xnlezPx2NSC36sn26K8j85RnJhTeCQLXaSs8QVtPt5I8TNQlYbh9VBUEMihpbpivYkuenpqNFUr5LMXC+t9QBO6MxQR94QkVn85WJRB5IdisGq2/6wafHD0aaZgMTmhcQbnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170042; c=relaxed/simple;
	bh=Hk7o/2MNF+SPViAou6tMu+gTJBMkqUPIlEz0oVdqO/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A1iCCEbZbjQfGN/Q878NuwW8XZxnDBHms8JS0LH/PDt4rgpqKlD0Nk6i0L6A1cqaNRl7I6/i88bAXx8XtqAt10bjWjC+joAtBUdMiEH5Kc98i8Q58aVP2S4PmFbC1c/0XyyYZjgKLFXUNqLhAyOwvnTTr1Q/x+Zu4hZOKw9PIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igsETIRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igsETIRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8C31F000E9;
	Thu, 16 Jul 2026 02:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170041;
	bh=D/kbmWc7zIzQ2+9O5iD3CjUNwk8KKKNcCz2U2Aa4fjU=;
	h=From:To:Cc:Subject:Date;
	b=igsETIRxLNBj8bBkO1mCq3DEYGB+9/24ajQgycrxkihXkyX/jv8wON3s5oMQxSwqC
	 5Ti62Sck7h7qrvO1I7Z1CdH5zMMApgfkXmbpYpZYHjHmE/5FbdFu6Ih7w9/vkQtrLb
	 rTRDmBmrJ0QbYxLfwCzJAUND5GOmA8Rgd+pXuyYkKpVE80geAh30jXLGSkE24uh2gT
	 mAVBvhFo5ypMn1ttGn6jTDfJONy/RjhC8BrRVMhbqPrKijVOCnWwxPgBDB7D/58NCi
	 sTG3g0TtTfhTzr9FUxuS1syqjgFhIGSLsHUA4Bue3kMHMUFw9ba0vMAfBrEhJErhq9
	 dfy9YYsdCztiQ==
From: Namjae Jeon <linkinjeon@kernel.org>
To: hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] ntfs: validate final EA attribute size
Date: Thu, 16 Jul 2026 11:46:35 +0900
Message-Id: <20260716024640.13396-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A replacement first removes the existing EA record, then adds the
replacement. Check the size of that final $EA stream before mutating
the current stream.

This avoids committing the shortened $EA stream or $EA_INFORMATION before
discovering that the replacement exceeds the AttrDef size limit.

Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/ea.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 0cd192752b7c..0eba3f41c7bb 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -250,6 +250,14 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 			goto out;
 		}
 
+		/* Check the final $EA size before removing the old entry. */
+		if (val_size &&
+		    ntfs_attr_size_bounds_check(ni->vol, AT_EA,
+					ea_info_qsize - ea_size + new_ea_size)) {
+			err = -EFBIG;
+			goto out;
+		}
+
 		p_ea = (struct ea_attr *)(ea_buf + ea_off);
 
 		if (val_size &&
@@ -285,6 +293,12 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 			err = -ENODATA;
 			goto out;
 		}
+
+		if (ntfs_attr_size_bounds_check(ni->vol, AT_EA,
+					ea_info_qsize + new_ea_size)) {
+			err = -EFBIG;
+			goto out;
+		}
 	}
 	kvfree(ea_buf);
 
@@ -312,8 +326,7 @@ static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
 	p_ea_info->ea_length = cpu_to_le16(ea_packed);
 	p_ea_info->ea_query_length = cpu_to_le32(ea_info_qsize + new_ea_size);
 
-	if (ea_packed > 0xffff ||
-	    ntfs_attr_size_bounds_check(ni->vol, AT_EA, new_ea_size)) {
+	if (ea_packed > 0xffff) {
 		err = -EFBIG;
 		goto out;
 	}
-- 
2.25.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616325;
	b=clVChf3iXdpm9RjS78lZX01qf/obsP3qfPYPEXoctYkfK3gYpdwI9/zDih0+SCbNgh8/
	 iafyZJuHA3O7AWQZ2SH+4M19DlIEH0KVTSSbP6Oks5LnjOJMgtBuPcf9yqkhkYNPe/Jtp
	 EFx7nJVO4zYikNl72htiCJ6Tk+CXIe8RGsW6ER/rIJcrXzIHDw1wr8bjmn8GhtVv2n4B/
	 whwFTZI5cxmBywn6mxofz+HM0Qm80dMuWtEr2hhYOVvZTinBWdkmhMmV9DCThbsdmJblG
	 GkZVTB419DmjcFLMUAGxuMZq/D+aQCpTDAFOi7T0uuSCWuxLkqfRxs7OZTeQE/UOINw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616325;
	h=DMARC-Filter:Received:From:Date:To:Cc:Subject:Message-ID;
	bh=/u0VjsxyPMAOJR7Q0uAek0+O26RmbI4zuyFPBC98RLU=;
	b=2TYYhA4hO/eCuXPsEp2BQBObNl9KlD7ykgOLjcT1qeab9QSrSWq2if2qPPk/23lAFPhH
	 AqX7jqM3Fs6w8soVTAxtpb5uyY7nNZP6D+ZBBuIHaEoCYzzTpBbem6NZN/RT2LD/aUiNE
	 NTySaDl8O2d1GLuFtwaRvvDWyT2VJneywfP/NSnqlohjZfnxlE7GP9SC5s49BMln9q2yA
	 Rf+0AHiZWLA765WIuqVaGX74t/SosUTp1dkaf8ujC4g3LrQae4xw1D4T5eE3yTfqPbchl
	 wJtWnUXrlf5D+5ozyrvjOepZDFAmuIuh8Yyyit/MegnzNd63BoaKxI+mfeKNozK4Plw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C9D606A31E;
	Wed, 25 Nov 2026 14:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89C9D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id DD70CC9300; Wed, 25 Nov 2026 23:18:43 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Wed, 25 Nov 2026 23:18:20 +0900
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH] fs/ntfs3: keep the reparse tag of a long symlink in the parent
Message-ID: <20261125-ntfs3-02-v1@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

readdir() returns DT_REG for a symlink with a long target once the
symlink itself has been changed:

  # ln -s $(printf 'a%.0s' $(seq 200)) l
  # touch -h l

After a remount l is a symlink for lstat() and a regular file for
readdir().  ntfs3 keeps the reparse data of such a symlink non-resident,
and ni_update_parent() takes the tag only from resident data, so it
writes 0 over the tag in the parent.

Read the tag from disk when the data is non-resident.

I tried targets of 10, 100, 200, 500 and 1000 bytes.  Without the patch
touch -h made the last three DT_REG, and with it all five stay DT_LNK,
also after chown -h and a rename.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 fs/ntfs3/frecord.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 16ac847..14b9006 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3039,6 +3039,36 @@ int ni_write_parents(struct ntfs_inode *ni, int sync)
 	return err;
 }
 
+/*
+ * ni_reparse_tag - Return the tag of the reparse point in @attr.
+ *
+ * The tag is the first field of the reparse data (MS-FSCC 2.1.2.2).
+ * ntfs_create_inode() keeps the reparse data of a long symlink
+ * non-resident, so it may have to be read from disk.  Returns 0 if it
+ * cannot be read.
+ */
+static __le32 ni_reparse_tag(struct ntfs_inode *ni, struct ATTRIB *attr)
+{
+	const struct REPARSE_POINT *rp;
+	struct runs_tree run;
+	__le32 tag;
+
+	if (!attr->non_res) {
+		rp = resident_data_ex(attr, sizeof(struct REPARSE_POINT));
+		return rp ? rp->ReparseTag : 0;
+	}
+
+	if (le64_to_cpu(attr->nres.data_size) < sizeof(tag))
+		return 0;
+
+	run_init(&run);
+	if (attr_load_runs_vcn(ni, ATTR_REPARSE, NULL, 0, &run, 0) ||
+	    ntfs_read_run_nb(ni->mi.sbi, &run, 0, &tag, sizeof(tag), NULL))
+		tag = 0;
+	run_close(&run);
+	return tag;
+}
+
 /*
  * ni_update_parent
  *
@@ -3098,15 +3128,12 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 		attr = ni_find_attr(ni, NULL, NULL, ATTR_REPARSE, NULL, 0, NULL,
 				    NULL);
 
-		if (attr) {
-			const struct REPARSE_POINT *rp;
-
-			rp = resident_data_ex(attr,
-					      sizeof(struct REPARSE_POINT));
-			/* If ATTR_REPARSE exists 'rp' can't be NULL. */
-			if (rp)
-				dup->extend_data = rp->ReparseTag;
-		}
+		/*
+		 * Reading only resident data here used to leave extend_data 0
+		 * for a long symlink, and readdir then reported it as DT_REG.
+		 */
+		if (attr)
+			dup->extend_data = ni_reparse_tag(ni, attr);
 	} else if (ni->ni_flags & NI_FLAG_EA) {
 		attr = ni_find_attr(ni, attr, &le, ATTR_EA_INFO, NULL, 0, NULL,
 				    NULL);
-- 
2.54.0 (Apple Git-157)


Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3F38D006
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396965; cv=none; b=ckJqxPhqj+NooJ04xmxmUmJRKP3LcODxNR9mIw2Lr4XsOJleN5e0aEds+4ayb8mnSn+BDAHgxknJmp45RM9UpqJseyrZq730wqwsnpK034T23AAJTw2ajxfrtDODyuMu4gqrYd1gEBuTeWXbk73+ZTzq8/vRbwQ77PQspap3FKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396965; c=relaxed/simple;
	bh=ATEaBAI73lUEaXMWj1UTJ1x+k1CBPqzbV6/lv1JpSfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rrglfa60FZAGVJ7wlHHCgENsp9WEIzAauhsuBypg9Yci6YWr4ioUy1lyqN5osdJyZ1MkoltHeoq/mC1yKP/sSp1s5Hre9fcOeChp2V90Ee5rfTpfWPeggA6KxLheVOcBuLcCp7F4CkIpbreZucFC5gcWDoyp183hlQrVmavAKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcq3IL6n; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcq3IL6n"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso1773205eec.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 21:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790396963; x=1791001763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4drxdtpU+7uIZLmeQZplqX59jz2gztIVdFaiKgMSjk=;
        b=dcq3IL6nCqHlvmuTcYU3cs/0nTbP5pkeMYeIm2TThSUmXwE88FBYxP1PSOINRRoy/z
         EsTbu761L0NHO9Dl0pK0PiSCVN9ZSckqpujkQbfEIIgKnSUoV9z+c0BmvW55oLtBdxhN
         N0I+NiIfpkw5Bd+/iYohTR7JfQu9UUcXV5qpJ8a/aPEK4PEZEqTXyUwNpHMJv/Mb8y/B
         1oPK9y8nOUBM2Ta+r+hwuiiotFhYLKN4WQxht+FmDo/O4hcha8aEjHyr01JePoSWg+AM
         f1TrTE7mZAX0RjerZJ5BIofzTyX7DlQomjWiNaC61LgV7WNtHonkKVg7e15wgfbub45c
         pTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790396963; x=1791001763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4drxdtpU+7uIZLmeQZplqX59jz2gztIVdFaiKgMSjk=;
        b=bAcKRufq0/EWc1KLDzNRopwI4APzO8SGsgYB/tcEU3WjNqF4PCD//3vjbQBfWsVLQo
         lUG6H2bOlY8+Es+HghYX7yurJlLGqD/JHYnATNOv3JMeJ9HW1rbx/YeiIPuvORVxynyj
         CHr2mG3e3UaguOc7gIZxdxkisEymbCnRGVFitqTEKzAoH4eHfrYrIEsffdYlvGbMEL24
         /hOaQ+rue+yzH2GtAakqfAMnDESjaVOpE11VM/05T5aR3zdAWUKF3qPsl9fkOGc7EABl
         v6CaobJRz0T4IWZ/HOcqzeZdZkybpn8p2nW+SeS32SFYkCxPV9FLDCdxiGTOA//OJdHd
         FBfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcQsY6tmWnydauTYqR7uIZmFgNwolTJTbi/mnGHZ6mGECpSJMR7WmcH3qs4gQ8AjZera5zkZDXQMmqSPjw@vger.kernel.org
X-Gm-Message-State: AFuF++lz9uG/Rh6S1HNaVprkRWQT7Nkcd9HC0TGM9HZIMHj1TsFlXw0M
	3yI7bi1iKF9NWL/1g+mXi2I2nUZHVpoblTnmt1h+h3HH/XWPbUTQzvyx
X-Gm-Gg: AYBFou1/qnjoZAKYB4clATlZy+/XGNSABKA3tSkPaKG2O3EBeME1ZNcU3OH1zXu5lEQ
	ko87Y7jDJomVG3VjlRpqsO6nKlvt1b7nxSbzgZh0Q3KLVgFBatWwOXF9sUtVXRGU1RD4KTSBmHl
	mzox96sXMXICPX/x+uxpqiO/rHVXTYIs90y/WeO3yvkww4HYM0iCDbfQRCvChGex5V0QWQtau+l
	G5HrgTP+t36bsdfsxgMxzbCwoNq1xXHXFJzVh7GtniPWLx4KIefKXClLVuaTejdfthXxlPG9BFP
	iJHxnEVRCgX7q9/sWeixbycdrcBYdu3aF2tJpFLXL+ZSDa2hmpVKmIUpgIOKbrOOBTTMLhDp3JB
	EQ+KTpjS3Hnw3B14ooKUPDJ5tPNWlXGPMQju8RetmX41aSVi4kVeMZkbg6ejXaUdS+sCm1LcHmT
	Cdlt2+pShz50zQutI2PFJdF4eyzUmwATv9SGOXbLsldFWcHp4gbX/1bq85jQFQKbyKEb55I4ihl
	aue2WjYXV8JFOL3wfP4xwTdbAIhahlW8FXCaRqNccnHextg+Hsc15yrY/ysLj68F3fJjo7b7rlJ
	IJi/lNlQU+lzoyBAsvkbZQUNUBW+Sv4SMxaUVicw4Ts6l/+8dxMPXXFQfZg=
X-Received: by 2002:a05:7300:16a8:b0:341:4466:1cd2 with SMTP id 5a478bee46e88-34271d8bc23mr1797403eec.20.1790396962873;
        Fri, 25 Sep 2026 21:29:22 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm6342963eec.10.2026.09.25.21.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:29:22 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] isofs: return long Joliet names whole
Date: Sat, 26 Sep 2026 12:29:13 +0800
Message-ID: <20260926042916.3277409-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926042916.3277409-1-matthias.goergens@gmail.com>
References: <20260926042916.3277409-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_joliet_filename() writes into a buffer allocated by its caller but
is not told how big that buffer is.  It hardcodes PAGE_SIZE as the
output limit for utf16s_to_utf8s() and gives uni16_to_x8() no limit at
all.  PAGE_SIZE was never the right bound.  Before commit b2eb2e288604
("isofs: Drop support of directory entries straddling blocks") both
callers allocated a page, but only its first 1024 bytes were for the
name, the rest holding a copy of a directory record that straddled a
block.  It could not overflow only because a directory record holds at
most 222 bytes of name (255 bytes, 33 of them fixed), which no converter
expands beyond 1024 bytes.

It also keeps the converted length in an unsigned char.  222 bytes of
name are 111 UTF-16 units, and the UTF-8 converter, used for
iocharset=utf8 and when CONFIG_NLS_DEFAULT is "utf8", needs three bytes
for each CJK, Thai or Devanagari character, so such a name can take up
to 333 bytes.  Past 255 the length wraps.  readdir then reports a short
name that usually ends in the middle of a UTF-8 sequence, and lookup
finds the file only under that name, never under its real one; a name
that wraps to exactly 0 bytes is not listed at all.

Such names are out of spec, since Joliet allows 64 units, but common
tools write them: PowerISO 9.5 and UltraISO 9.76 both keep up to 110
units by default.  Windows, for which Joliet was made, returns them
whole, including 111-unit names in records that leave out the padding
byte.

Return them whole here too.  Pass the buffer size down and have both
converters respect it.  utf16s_to_utf8s() stops before a character that
does not fit, and uni16_to_x8() now hands uni2char() the space that
actually remains and stops on -ENAMETOOLONG, as fs/hfsplus/unicode.c
does.  Both callers pass JOLIET_NAME_MAX + 1, room for 111 units at
three bytes each plus the terminator; no character set needs more than
three bytes for a UTF-16 unit, and isofs_dir_record_valid() already
rejects a record whose name_len claims more than the record holds, so no
name is cut.  Make the length an int, which is what both converters
return.

These names are longer than NAME_MAX.  POSIX lets the limit vary by
filesystem, reported by pathconf(_PC_NAME_MAX), and the VFS limits a
name only by PATH_MAX (verify_dirent_name() in fs/readdir.c).

vfat, exfat, hfsplus and ntfs3 already return names of up to 255 UTF-16
units, 765 bytes of UTF-8, and such names break the same things there:
copying the file to a filesystem with a 255-byte limit, such as ext4 or
tmpfs, fails with ENAMETOOLONG, and cp, tar, rsync and Python's shutil
report that file and carry on with the rest, so the copy is incomplete
but says so.  glibc's readdir() returns the names, but the deprecated
readdir_r() skips them and fails with ENAMETOOLONG, and an inotify
reader with the buffer size inotify(7) suggests gets EINVAL.  In the
kernel, fanotify reports events on such a file without its name and
warns once in fanotify_info_copy_name(), and a directory with such a
name cannot be reconnected from a file handle, because the generic
get_name() in fs/exportfs, which isofs uses, skips names longer than
NAME_MAX.  Cutting at NAME_MAX would avoid these, but would list names
that Windows does not show and that can coincide within a directory.

Every name of at most 255 bytes is returned exactly as before.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/isofs/dir.c    |  4 +++-
 fs/isofs/isofs.h  | 11 ++++++++++-
 fs/isofs/joliet.c | 27 ++++++++++++++++++++-------
 fs/isofs/namei.c  |  3 ++-
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 5e541e765f54..eebea133094d 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -195,7 +195,9 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 		if (map) {
 #ifdef CONFIG_JOLIET
 			if (sbi->s_joliet_level) {
-				len = get_joliet_filename(de, tmpname, inode);
+				len = get_joliet_filename(de, tmpname,
+							  JOLIET_NAME_MAX + 1,
+							  inode);
 				p = tmpname;
 			} else
 #endif
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index 79ca0256843a..47c43a3c6a61 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -121,7 +121,16 @@ bool isofs_dir_record_valid(struct iso_directory_record *de,
 			    unsigned long offset,
 			    unsigned long bufsize);
 
-int get_joliet_filename(struct iso_directory_record *, unsigned char *, struct inode *);
+/*
+ * The longest name the Joliet converter returns, in bytes.  A directory
+ * record is at most 255 bytes long, which leaves room for 111 UTF-16 units
+ * of name, and no character set needs more than three bytes for one unit.
+ */
+#define JOLIET_NAME_MAX \
+	((255 - sizeof(struct iso_directory_record)) / 2 * 3)
+
+int get_joliet_filename(struct iso_directory_record *de, unsigned char *outname,
+			int outsize, struct inode *inode);
 int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
 
 extern struct dentry *isofs_lookup(struct inode *, struct dentry *, unsigned int flags);
diff --git a/fs/isofs/joliet.c b/fs/isofs/joliet.c
index c0f04a1e7f69..d37e67c5e36f 100644
--- a/fs/isofs/joliet.c
+++ b/fs/isofs/joliet.c
@@ -15,19 +15,26 @@
  * Convert Unicode 16 to UTF-8 or ASCII.
  */
 static int
-uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls)
+uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls,
+	    int outsize)
 {
 	__be16 *ip, ch;
-	unsigned char *op;
+	unsigned char *op, *end;
 
 	ip = uni;
 	op = ascii;
+	end = ascii + outsize - 1;	/* leave room for the terminator */
 
 	while ((ch = get_unaligned(ip)) && len) {
 		int llen;
-		llen = nls->uni2char(be16_to_cpu(ch), op, NLS_MAX_CHARSET_SIZE);
+
+		if (op >= end)
+			break;
+		llen = nls->uni2char(be16_to_cpu(ch), op, end - op);
 		if (llen > 0)
 			op += llen;
+		else if (llen == -ENAMETOOLONG)
+			break;
 		else
 			*op++ = '?';
 		ip++;
@@ -38,21 +45,27 @@ uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls)
 	return (op - ascii);
 }
 
+/*
+ * Convert the Joliet name of @de into @outname, a buffer of @outsize bytes.
+ * The result is at most @outsize - 1 bytes long; a longer name is cut at a
+ * character boundary.
+ */
 int
-get_joliet_filename(struct iso_directory_record * de, unsigned char *outname, struct inode * inode)
+get_joliet_filename(struct iso_directory_record *de, unsigned char *outname,
+		    int outsize, struct inode *inode)
 {
 	struct nls_table *nls;
-	unsigned char len = 0;
+	int len = 0;
 
 	nls = ISOFS_SB(inode->i_sb)->s_nls_iocharset;
 
 	if (!nls) {
 		len = utf16s_to_utf8s((const wchar_t *) de->name,
 				de->name_len[0] >> 1, UTF16_BIG_ENDIAN,
-				outname, PAGE_SIZE);
+				outname, outsize - 1);
 	} else {
 		len = uni16_to_x8(outname, (__be16 *) de->name,
-				de->name_len[0] >> 1, nls);
+				de->name_len[0] >> 1, nls, outsize);
 	}
 	if ((len > 2) && (outname[len-2] == ';') && (outname[len-1] == '1'))
 		len -= 2;
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index e1c571478e8f..c65cc78583ba 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -109,7 +109,8 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 			dpnt = tmpname;
 #ifdef CONFIG_JOLIET
 		} else if (sbi->s_joliet_level) {
-			dlen = get_joliet_filename(de, tmpname, dir);
+			dlen = get_joliet_filename(de, tmpname,
+						   JOLIET_NAME_MAX + 1, dir);
 			dpnt = tmpname;
 #endif
 		} else if (sbi->s_mapping == 'a') {
-- 
2.55.0


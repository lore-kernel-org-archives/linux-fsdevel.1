Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937149;
	b=fy1VeGtWcqgZ1KDE9a8pAlsxsLJCYrRtbyHa4CYlpnuQpLGjJD5H+xYKi0HOZwHY/+HE
	 e9oQNCCdg99iaA9yAsKupmdGIDUl/sHdRZ6EzrvO4rOY/zL+y1ETP5fEP2/dvItpaaziy
	 u3bMe8qwYEjyEPMds/9ZVh8RuxqdrcdtlZj4vFajIDdTi4q3Mw95gI2+CRLjjOItETm0N
	 pl4OC3kA1/9hQ3KamAzoqkpNksz15F8egCzNqqeVWJ0LcVElxcK+AlXrdcVMfE8zuigf8
	 rcQCVzdKZ4DI4j5kpSIm6yYy3TyNYPRSu2HeLS6haH1Zb0g1jRExMlDihq5jKQWESKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937149;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GXALsXMc+vuhe8fASc4wg4+RAc2sW67vDWwNl5cZHZE=;
	b=gb2me2+R7Jix/AodlxTf5SmYqlm6Z9IMZWbI1DSKPtO1FK5xg0guCis/AhuvPOMcxOzq
	 lgazM3TaLbKnk/Ov/UVdC5QZ13GsHuMTfNEgcLdW1BlX0VUEWOl76zBkf3iM7RVQzI1Ew
	 QzSNwlpck0Y0TD0Hh7C+i0HnsaThSVZpKzycxWepeR4F6u8THluintTGyho7VAG6IT8z7
	 mVnaVAwtY7MA8CGnT2JyjSSu1bvl51TRkdpysjCWUM2oTn5LRqiclN1GGd+VMmp5ebCmX
	 3558oZdjsM0uxpShAz0MrDUnv4X6oA6a+f9XlX8zV94TiZlGtrabpr+ZFrnDP7vQXAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Xwxkzez7;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D575606A336;
	Tue, 17 Nov 2026 17:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D575606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Xwxkzez7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794937132; bh=GXALsXMc+vuhe8fASc4wg4+RAc2sW67vDWwNl5cZHZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xwxkzez7m3Y5gcqPdmVl+62sMI+PuAkAqwwR8QkfDzQDOfwjI+mHQ3A0JyrmoNYc2
	 QQtYKmD6ejFiiO53J0qwVt6qk2AWvMaomLlcjTlTNaKd0UTGIV5ZAewfqPmEHPErhm
	 ta+jQT+dvM15OI9ZS18eDprYSiSim3q4UnPPx2RU=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 9B32564A; Wed, 18 Nov 2026 01:38:51 +0800
X-QQ-mid: xmsmtpt1794937131t8pvh843q
Message-ID: <tencent_510BD3ADA8229FEA28E3D4C9EF8491482707@qq.com>
X-QQ-XMAILINFO: MQAOa38Yz/8//22ZTbxLw1sKnEnSGXMXE8B5TgOUEdkFUor1xHTCyCsvMUvFKE
	 CBn4EVi05dKFwY8iP9ORwlNJGyT5t2tfpWgVsFJO/w1QHcMmlNEZ/TIqCDuIFDpYIgPY19alnLHs
	 JzvSRqxOEKD95PfyhM770jLehpq+ex92xPHlz9Mj7kZo96vOxj73WM1KXLDrvBWOeFHgLUOBkSlQ
	 EfN9UOHqt36nOwBosGV76pL6F9VLCEThHzAKPiQ+TJy/a3JtPM8ZprpIivrqog0cLBL58Fxm9PqB
	 K1ptIRz+Tb+1LTBao5gxfVWzOdQpLQZ6oGIJ8W5DqiUJqyu0eKG4kV3I2W6C/IkVJFy0CHxbiaqW
	 8zks+9qLuxqZk3PYigqi63IHCy689lwW05sSAIjbFFVDk8R6e8HJb9CkjGmpYebsd29GQrtrLAFu
	 tUQWOSWszKeyLQsD1Zpv0R6XfUPkNYvmZynyHghyVx82DopI9yTQCSBMfoYEnWlwi9ffNPvmb71i
	 I49X9WWej5Kn2bhBhMhqFMeqQ/Fj3zmsE+MHFEZvu/Znh9EbToL3Zehys7TxM51ibUwZKvPR+qwO
	 YGrUyzttUqsKWeOqCPfjOY1ogbaT9XsGnskeTjuGPSg/62gWNqFUi2jiauagnDn1+NfvtQzQpAMm
	 6Ye6KHaYw9q31pYPfROMa7yYdJqFiFrWXZyqoYrphWP+z9Lpktx26745HXce0c6FAPKM+x8vPp4M
	 jfySSofjqHLmmt+TptWD5C19iFvzEVL3OfDu+4kVVi8dXOkMHxHppm42uFhLvSOsFFXvjH27czRC
	 q5DkOt7zKg4Wl2zo0izHruul9ENwtHvuLJVEnqNu/1CAUyiXzJ/wDcdOPpYkN0u8a5DU+i6gyR0+
	 CP3E6M34YQC/xaIerxojz7WSmFjc6GmdbjoCMFkC3moDUhZIPiDQkEOfPfQ/zbKBOn3LZGfJRQgy
	 akGsEyoZ+20XYKgcQa3FjSrTKiZDit2UVWqmAngnhxIH68RzllfcNgi+TZajEi663oQ4ziDSdbf9
	 Crt1n7KnakDYfba/8eDukV8YWjIMi6t6LFUGAMdZbz05CrS67HTMJxvx1w6I7c7oFdISw9GOrnnn
	 5N3rbY
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Guikun Yang <yangguikun19@qq.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ufs: validate fs_cgsize when reading the superblock
Date: Wed, 18 Nov 2026 02:05:00 +0800
X-OQ-MSGID: <patch-ufs-cgsize-v2-20261118@qq.com>
In-Reply-To: <20261117-absorbieren-geduscht-holzlatten-0552aac29cc8@brauner>
References: <c5-ufs-cgsize-ubsan-20261031@qq.com>
 <20261117-absorbieren-geduscht-holzlatten-0552aac29cc8@brauner>
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
Content-Transfer-Encoding: 8bit

Hi Christian,

You were right -- the v1 diff was hand-written and did not apply. This
v2 was generated with git format-patch from a tree I actually built the
change in; both fs/qnx6/inode.c and fs/ufs/super.c compile cleanly and
the patch applies with `git apply --check`.

Changes from v1:
- real index lines, hunk headers and context from git diff
- Fixes:/Signed-off-by: placed in the commit message above the diff
- function signatures match the current tree (new mount API)



---
fs_cgsize is read from disk into uspi->s_cgsize without any check.
Its only consumer derives a buffer count from it:

	UCPI_UBH(ucpi)->count = uspi->s_cgsize >> sb->s_blocksize_bits;
	...
	for (i = 1; i < UCPI_UBH(ucpi)->count; i++)
		UCPI_UBH(ucpi)->bh[i] = sb_bread(...);

struct ufs_buffer_head.bh[] has UFS_MAXFRAG entries, so a crafted
fs_cgsize whose block shift exceeds UFS_MAXFRAG writes past bh[]
while loading a cylinder group.  Reject a cylinder group size that
is zero, smaller than the fragment size, or whose block-shifted
value would overflow bh[].
---
 fs/ufs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3569ac92b..6ae7f9cee 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1140,6 +1140,13 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	uspi->s_cssize = fs32_to_cpu(sb, usb1->fs_cssize);
 	uspi->s_cgsize = fs32_to_cpu(sb, usb1->fs_cgsize);
+	if (!uspi->s_cgsize ||
+	    uspi->s_cgsize < uspi->s_fsize ||
+	    (uspi->s_cgsize >> sb->s_blocksize_bits) > UFS_MAXFRAG) {
+		pr_err("UFS: invalid cylinder group size (%u)\n",
+		       uspi->s_cgsize);
+		goto failed;
+	}
 	uspi->s_ntrak = fs32_to_cpu(sb, usb1->fs_ntrak);
 	uspi->s_nsect = fs32_to_cpu(sb, usb1->fs_nsect);
 	uspi->s_spc = fs32_to_cpu(sb, usb1->fs_spc);
-- 
2.53.0.windows.1


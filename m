Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484901;
	b=kMEm5tMgFBcBuD16PC+n0+aX40EmdNqfKq463oCNq/NYo89AyJiu2k7ClKcMi8voEYwr
	 Pw5asbT5W+UN7U337pJmaOB/7TuIQThOIBoh6bQvAwp8TrkfxqDJp27OdiBBv/acSTjA3
	 THP8xQwekGWI+5sYpHe8CN7t0cOlQ+P3FjEcKxHGdWcB8+M1C/n3Op0QxLh2nPmChsusr
	 fhCdjMzNhI3AKBDDrX0X6B+wtBHkvW6irBlvMjXZXR7uSDWbYHsmR9g0Gl6idogYpqE8M
	 FF1Za/M5uLJyZWcGQEooiy74PEQE/lFUD2mv24UXMfgw3nil/284UyNb/rO0ZSKUY6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484901;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/qgqb63emJtbmEvECWUBoG8vTCiAc0/8KBNN0ukAZoo=;
	b=A8hEKhVQg6qiSIni6HHN+rZbEPDmW5zwaESk6SnmF/N8GrvIhRewkfkE7Cl+4SaM1LQf
	 wxRG2iJy9JoG2tBg9wn846edXTZBasKEFCP+9xVMLTHjRlpRJ7jboEIyChFn55zHG9s10
	 Ty8LKe5cgROZpFHfMZTYUEaiQdadRoghFfYMdIv8gcIXPfeE0rI5EQ5Y0TBCEEFbcPzgx
	 IHRPYf7QcJble6aJKJYWyCPDZ96Qw7isylENwajHu/GGTltlH4efBIS+AWunO5oop/hv2
	 SjqdFDJtQUV1RMGNav1SKyRnPobv/iohW/a2EllWR8Yob2jkdqbDMrW5y3nrv10lF2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VBiXzFEn;
	arc=none smtp.remote-ip=203.205.221.164
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64B606A319;
	Tue, 20 Oct 2026 08:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE64B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VBiXzFEn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792484890; bh=/qgqb63emJtbmEvECWUBoG8vTCiAc0/8KBNN0ukAZoo=;
	h=From:To:Cc:Subject:Date;
	b=VBiXzFEnw5677L419ZmWNPfYL+QuAb0vpDvG/ct0CuQvDBpS59gaj6SbmoBdMEeZJ
	 9sqiAt+FntDNok0Le2h8Z2kSa884vQHfNkeWBLHeyHVWf7x/Yz5vGxdhY3cbi84EBe
	 J6ayDN/JFu8tfvCxlYVyVXL1J2ysIXi9sfAPL/sI=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 7080D04E; Tue, 20 Oct 2026 16:28:08 +0800
X-QQ-mid: xmsmtpt1792484888t05nr2css
Message-ID: <tencent_A6E5F84C4461A52A7F5B8E203A65989A460A@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Julmld+xK4A0N40cbsy6xQLI2Nx8Szl7OLPpmra9kuqIGk4/E2Yz
	 IRjCUEUZGT/GNG8GkNB49BeYR8Sd/w5AalcECFge1VnyVkiaA1HxaN7ijhKNEZ5ckXSoc+dMoEL+
	 R/tXICU3+I/z57UhPPDMydEPnqhR3I8vzJ4MMFtenpJDxQjNvjqmzbSCWz32+g8K8kWvFnVF43DL
	 lRDBo9AfpbN3ToB6HcVHVK2kVGe6ng+XvzFve84zP5/xD2qvTD70fOE/xwj9jWHs8F6IJbyIFwuo
	 jO02rTn/gc7O5ggfNp17DI8z/fttP/3AQSs0MoMx8v7rPwORe57iOFM4o1OOKHa2c2kroPPW+6Hp
	 M8zd6aFg7kOFXRv0hnR7bgHGPaewt53IiAmbOUqhQJdTu2GR20dvbu2wb/2fmyoBg5fNOhZFe8jF
	 i42Y0xnJRftyPF0j0zTSbQIOjThWjeio+wMEp3Q9hFdP8H1H5irK+LsuD6KerAqG5xYfcUCGgTTl
	 Dhiy1SRL1DNYbJ33mP44kvbMSBlJdt3aIE8Qrt2ke6NrYlXXoQZZyldKmmxys3UAPb9ObixLPzWz
	 LxfRmhEOfpz0zqEYkgCmmsZzFGQXiFTIdKeKiIaOD8y4zDKW0I+M0BjrQSGND59GY9TNm9YZ05Di
	 fS2oGK61Z/ezdWIDF0x+dogv9DeLlnN9f1gsNhfsPnC41EWHsEnIKuEGvZUx5ZKhYkNM9XlQ7WEM
	 sOFeJUuq/6UGqa8iX2gzbqMbWRBlbGQtN+LHi4pZOdtHUPOvoqMGXmD6FYwfD/c2WrImd5Qu94Mx
	 d6x9LKpNdwchHc+UjdgdqX+3WvhqmyUG5Ri4cGhgqLzGvN/6Jebl9qirYI+Jju1xczfwUkBjBegA
	 +psFnV2DdtoErWs843JSPrquWmN3d7J+0TjPwNiguFoy7aYrXaQHLyl99zjnaJMOitqZHOCpRCgP
	 kcvZYk981wIAc6xvuy8GsP03+R+jeQEqwlOPCroToneE6wk1ne5DgwwdlusU03I6M7sMQxJS0mKI
	 usKEn8LiZQG6+fl9IpUMDOo6kvmVv0cj8VvluplNONa7X/DlBQri6fO+S6DgKCUEV+XleegsPpxv
	 Iq+hX9
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: yangguikun <yangguikun19@qq.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] udf: KASAN use-after-free in udf_fill_super on crafted LVID
Date: Tue, 20 Oct 2026 16:28:07 +0800
X-OQ-MSGID: <20261020162807.36228-udf-yangguikun19@qq.com>
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

Hi Jan,

Mounting a crafted UDF image gives a KASAN use-after-free in
udf_fill_super(), before any file operation:

  BUG: KASAN: use-after-free in udf_fill_super+0x1ce4/0x1e10
  Read of size 2 at addr ... by task mount
  Call Trace:
   udf_fill_super
   get_tree_bdev_flags
   path_mount
   __x64_sys_mount

  Kernel panic - not syncing: KASAN: panic_on_warn set ...

The root cause is that udf_lvid_valid() bounds-checks the start of the
implementation-use area but not the size of the structure read from it.

  static bool udf_lvid_valid(struct super_block *sb,
                             struct logicalVolIntegrityDesc *lvid)
  {
          parts = le32_to_cpu(lvid->numOfPartitions);
          impuselen = le32_to_cpu(lvid->lengthOfImpUse);
          if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
              sizeof(struct logicalVolIntegrityDesc) + impuselen +
              2 * parts * sizeof(u32) > sb->s_blocksize)
                  return false;
          return true;
  }

  struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
  {
          partnum = le32_to_cpu(lvid->numOfPartitions);
          offset = partnum * 2 * sizeof(uint32_t);
          return (void *)(((uint8_t *)(lvid + 1)) + offset);
  }

With blocksize = 2048, numOfPartitions = 246 and lengthOfImpUse = 0,
the check computes 80 + 0 + 1968 = 2048 and passes, while
udf_sb_lvidiu() returns lvid + 2048, i.e. exactly the end of the
block. udf_fill_super() then reads lvidiu->minUDFReadRev at +40,
which is past the buffer. Placing the LVID in the last block of the
image moves that read past the end of the file.

Reproducer

An 80 KiB image. The generator writes:

  - VRS at offset 32768 (BEA01/NSR02/TEA01)
  - AVDP, PVD, LVD, USD, IUVD, PD, TD
  - the LVID as the last block, with numOfPartitions = 246 and
    lengthOfImpUse = 0

Mount with:

  mount -t udf -o loop,ro udf_lvid_oob.img /mnt

The crash is immediate; no other access is needed.

The image is included below, base64-encoded gzip. Decode with:

  base64 -d udf_lvid_oob.b64 | gunzip > udf_lvid_oob.img
  mount -t udf -o loop,ro udf_lvid_oob.img /mnt

udf_lvid_oob.b64:

H4sICKsg12oCA3VkZl9sdmlkX29vYi5pbWcA7d2/btNAHAfwswu9MCD6COZfi8oSsjCwEGiRiqJW
akIXpi5AJUgZQOI54BGYeAAW3oJHYGFh8YCY+dlNpFYIFRWkhubzOSnWxbZ0/nn43lmWnBIAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAkO6t97u3CnUAgHmyOdzu9uQ/AMyVkfU/AAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAHKdIZfoQv++/1blq+wcuPVp7MNjZWPvNablIB61UQgD47yxG
gj+LHH/7sc6Xo/8v8nypmTiM1oej07mkTrSUVreGo34Vs5jq/v6Ll8/3dsevmp1lsTA9Kl05UofJ
3Ge1OWWwU22Mn+wf2l/OyieSY9wrzVgXfbMZgJPLkfi7kXzfH9a5ycOFaQ521AYAzqpzkf+fIvGf
9up8te0fvwa+ONgbv35zakM+764BwN+Gadmu+N/F+v/aJFzbmL+5Odzu9n45flaeg0+HceMP5isA
wFGdyP+VNk3rfF05AGAulNG+RP7feVyl5eaPuylVh7cAwJlzIfK/F/l/+3Odm/fK09LXXJzgufmP
ybYPAMy8n4I53nYAQAEA

Fix

Check the size of the structure that is read afterwards:

  --- a/fs/udf/super.c
  +++ b/fs/udf/super.c
  @@ -1619,7 +1619,8 @@ static bool udf_lvid_valid(struct super_block *sb,
          impuselen = le32_to_cpu(lvid->lengthOfImpUse);
          if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
              sizeof(struct logicalVolIntegrityDesc) + impuselen +
  -           2 * parts * sizeof(u32) > sb->s_blocksize)
  +           2 * parts * sizeof(u32) +
  +           sizeof(struct logicalVolIntegrityDescImpUse) > sb->s_blocksize)
                  return false;
          return true;
  }

With this applied the same image is rejected and mount fails with
-EINVAL; no KASAN report.

Tested on 7.3-rc7. The same image also crashes 7.2-rc5.

Found by syzkaller-style fuzzing of mounted filesystem images.

Signed-off-by: yangguikun <yangguikun19@qq.com>


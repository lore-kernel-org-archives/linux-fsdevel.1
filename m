Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025753;
	b=c3iPOb5anfxZ8TGTd1BJMTk91jMwXBX5uBDiizV3lnDwvpCqCuHBlyflHPAlXHl0LyWN
	 vXYZo9/HoUtVyWrPb0i0FwMSvehoH6HTh++nha5pjYTcocIrcBXkXtB6amvxrhLfgRagp
	 WHcVmHZWGVdtb0LP95gIRiRYuOwF6fFbV89oYXLiJimVyZCcOhfO5gb1Cx0hJiW4/AdQG
	 cQqeKNPosoPUwRpyty9m8NBdGME0klLpXSGPTLLhfz99m/gDrnwWwDL3Na5/jajjNz4Lk
	 QszjaKqQSoXO4GFZT5lhTnTZ2iYAN5Ai4StseISNIgUFuIM9eL1FhVo7YYxBRsjIU4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025753;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:In-Reply-To:
	 References:Date:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=iX4UozUO3MlxlRY8rbobS09QzTYf/voPJs4YZBBQplg=;
	b=CgEfYOJKE/uFoB97NUftgXecaDbqgdN6Mb9XoxpwIAZHeANIsbCJ0adL51t/biT2Ca9V
	 xQeSDc9VBc8420baSVUfErHS9jQOn+d+U+HT7Mm55wvpFlAWpCnGCzV4bBcWBCzCZ0D6D
	 JRhMXiDqFxekJsMoN2Kn73gqRYiXBLm3leCrAu0SVryixrj2Pfapyr3hayoXjx8crguDW
	 TQzwwizT6xpQ0fAchTNiCnGRpYkPTeuIWbdd0JEZWtwxlgyECSPW5/opghYI/w8wS9iHN
	 rZj5WiE53+nYe6yVetPDWtTqc7HgbDhblw7GaHTunWoS8CMK2OUb2g//0uKtF9FmNZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=shlc24jQ;
	arc=none smtp.remote-ip=203.205.221.245
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B3606A326;
	Sat,  7 Nov 2026 04:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 771B3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=shlc24jQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794025743; bh=iX4UozUO3MlxlRY8rbobS09QzTYf/voPJs4YZBBQplg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=shlc24jQJ74+lIJeryVOU3Ie4wZZa93jFmqZaAcH2LIpeuTo1G8vkx4L6hVHT3cX3
	 wL5Ku3/ISAVoG5Rus/iGgpSVL3B5H4jsx30ikHv03OZVjmYid6refOjJI7mrABvXD6
	 q5FeRFAzJJUENxnBwJ08l8NRx9nww8+0lCeRymyA=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 7411C4AF; Sat, 07 Nov 2026 12:29:01 +0800
X-QQ-mid: xmsmtpt1794025741tbj3z0pz6
Message-ID: <tencent_64A24695F85844F5A5227DB38C503A219B0A@qq.com>
X-QQ-XMAILINFO: OdpilHhB3Diu2r6R4FAx8c2RirsIeTm5JbdNmOK7nBwz0WY/VumI1MvGEw0FG2
	 ogEgiRKlib/BThli9MIVJbUQ7UNuJ6ON7Zs7C31Td1Y1rjWyLvmdDBoXv/+PbTznfn8E4C8Gimkh
	 zW23l2yU7hdfda6Gsc6GKoizcI5ml1YwNFVAJgp6nHPX2w3CMlcQRqvjmoj5Db7ANX1H3gRuwRlb
	 7s7g2Y1nZpHsvTwAdPc+Xcwr+nhrsmJ47K5fMoEm0+7M1XnNbyHbf3/u8y7ze23bnRswBboF3xwr
	 +dd3/qI/g81GAzPI+HKoK9d9iEUsT9MyaY626SdQWWSXIM7z8fACyMZJVOfgp41KKXCdhxEx8k8K
	 OBCtItnwlK7ISuhAUbfS1l33XOK7/0NoPPR7RsBCl2QtoPwxi11C/YYdDFqwjt46tAi6NJKOWOt+
	 SFxT0L8WVrt8kZFwptgUGVmwzCrTmrgKl9Of/tplR47/Kg+WyRr71M8Rd8/+69FxL/SxOKOF2vj+
	 nln10/A/MhAurVkCJxNOU6tEdFbBI7VZM50AAzfg2/FhfThx1mcI8/NkIFTYSbPMFQVfG6vMVvdE
	 /ZsgeaFTD3lERGAkECJ7kg3NRRIeMGT75lEOxiGoJvm367HwB8lM4qiagbBX3U7TsjVh+5MKfr41
	 ODKyZB5CvtZSpYjxtYfyHvLzBOVtzeKD9flN2nOsigtNltjGjAiPZyNGjAvRJx3EQ7OvApXFOjAh
	 jHlZBOctFNWBrF/NwPwu8WXEgNPbcc5eX/vbqBhqOdr9PWks32lANlHE3ES5rl7qpo1kAkY4eGPM
	 sAvItfKsbJ/H2qEzY5BbC2qLUbCIxhqiEOxMBH6KYxql4ILyBlCqJhkh5qghReU4DsNdiNhDMu0+
	 BWiZ/v5tikGq0DdSLYKgsEf9yBusrPKXgDG4/rwU3CYOp84q+4z39x4KBADn9y2WvKLZvnBFGdky
	 SemNPvk8tkxaoeDTTnoy4e3F92lyeFRr5cP1uVqh42QXO/Txq452PzgbVszYfTNyk/DRlTUdK6R7
	 nVM2G2siFp6Yk2blcc7cONAzACkZnW4udyfQ5cPUMwjEgSEeFEExtXlCiVRWE=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Guikun Yang <yangguikun19@qq.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: ntfs3: two out-of-bounds reads in $LogFile replay (restart page
 resize, restart table offset)
X-OQ-MSGID: <c26c27-ntfs3-logfile-more-20261106@qq.com>
In-Reply-To: <c21c25-ntfs3-logfile-oob-20261106@qq.com>
References: <c21c25-ntfs3-logfile-oob-20261106@qq.com>
Date: Fri, 06 Nov 2026 23:30:00 +0800
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

Two more in the same path while re-checking it - one OOB read, one OOB
write. Same forged-logfile setup as before, mainline 2026-11-06
unchanged.

## 3. Undo pass indexes the open-attribute table without the bound the
   redo pass has

The redo pass bounds target_attr (fs/ntfs3/fslog.c:5105):

  t16 = le16_to_cpu(lrh->target_attr);
  if (t16 >= bytes_per_rt(oatbl)) {
          err = -EINVAL;
          goto out;
  }
  oe = Add2Ptr(oatbl, t16);

The undo pass does not (fslog.c:5251):

  oe = Add2Ptr(oatbl, le16_to_cpu(lrh->target_attr));
  oa = oe->ptr;

check_log_rec() only validates target_attr when lcns_follow != 0, so a
record with undo_op != Noop, lcns_follow = 0 and target_attr beyond
the open-attribute table reaches oe->ptr outside the table:

  BUG: KASAN: slab-out-of-bounds in log_replay+0xafda/0xf580
  Read of size 8 ... located 104 bytes to the right of allocated
  344-byte region (kmalloc-512)
  Allocated by: init_rsttbl -> log_replay

In our run the table is 0x158 bytes and target_attr = 0x1A0.

Suggested fix: mirror the redo-pass check in the undo pass.

## 4. Dirty page table size underflow in the analysis pass ->
   OOB write via copy_lcns()

The number of lcns per dirty-page entry is computed differently in
two places. The version-0 conversion has a guard (fslog.c:4357):

  t16 = le16_to_cpu(dptbl->size);
  if (t16 < sizeof(struct DIR_PAGE_ENTRY)) { ... goto out; }
  t32 = (t16 - sizeof(struct DIR_PAGE_ENTRY)) / sizeof(u64);

The analysis pass does the same subtraction without the guard
(fslog.c:4666):

  if (dptbl) {
          t32 = (le16_to_cpu(dptbl->size) -
                 sizeof(struct DIR_PAGE_ENTRY)) / sizeof(u64);
  }

dptbl->size is an on-disk u16. A table header of size = 0x10, total = 0
passes check_rstbl() (rsize nonzero, no allocated entries) and
check_dp_table() (nothing to enumerate). The unsigned subtraction then
wraps, and copy_lcns() copies lrh->lcns_follow = 0x60 entries into
dp->page_lcns[] of a table that extend_rsttbl() allocated for the
bogus per-entry size - the 29th entry writes past the end:

  BUG: KASAN: slab-out-of-bounds in log_replay+0x8b01/0xf580
  Write of size 8 ... located 0 bytes to the right of allocated
  280-byte region (kmalloc-512)
  Allocated by: extend_rsttbl -> log_replay

This is an OOB write, unlike the three reads reported so far.

Suggested fix: apply the same t16 < sizeof(struct DIR_PAGE_ENTRY)
guard (or reject size < sizeof(struct DIR_PAGE_ENTRY) in
check_rstbl()/check_dp_table() itself, which covers both sites).

## Context

Both reproduce 3/3 with panic_on_warn=1, mount(2) alone, clean image
mounts fine as control. The forged volume is the same one used for
reports 1 and 2 - each of the four findings differs from the last by
one field of one log record.

Four different missing-bound mechanisms are now known on this replay
path: buffer resizing (report 1), unbounded in-record offset (report
2), redo/undo asymmetry (3) and the version-0/analysis asymmetry plus
underflow (4). Given the pattern, a systematic pass over the remaining
offsets in log_replay() may be more effective than fixing these one by
one - happy to test any patch.

Both sites are unchanged in mainline as of 2026-11-06.

Thanks,
Guikun Yang


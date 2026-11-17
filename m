Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794876850;
	b=eXilMd8NcleEK0q0XS0KwQYgWtLyUv5xXeX8CC4H3YnLW6n/gNUr8MBnyWwuZ81JLexb
	 Dz9bbvF7cV8GDU22lbrcTJpldt3EP7AVERI8Kenp63xaiZBn5FzIWTtPhSTAxSW1WNTAw
	 Gq6TT1nnLrdcbV8ZvUPFSh9WY0fw+zcK9dl7kTGgACUSUGYlJkNUykhY3HpXindY6iqyP
	 grkcHG+mY6ALhfQpSgmcNp3eZLO4Z74zN+oH0llQzzR7ZZRLPJKR10gmQYTVSBFYSmHVk
	 LAa0isXXBynb11kfENRz79n8rNC2NJN//MVEPxc+luUrYOWRJfh5BLdlcH1+VTEN/zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876850;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=D3F7wDt4hle7ND8YlixfMQBigLOCmZnPNNViCkmiGls=;
	b=n4PEfYX++M7o5hF8yHAC+TSsfErTX00aHyk0RDZVh6u/hCBatNyIpcer4Ls42ulLJOO2
	 UWiX7ipLojSy8vyOtuvaggOS/Wy7YB2vEkhxKA28zEE/vvcS5weZfPLpucByL0Bfp4Xdm
	 FPyYpYoSyCCPe+LIvRd+uPd8KMeUe8bmuNqB3vTHRAZQc5QdHCTa1RGfJKeV8aGnxEInf
	 FHGDYdqJcRLt2IHO0JV/pcb9yDbFqPojAy9Fo164aFNlqfMsv+DFsIbYNazV50woj0WOB
	 2zSRoWlIAXCpUU94TYb5s527oSKv/fqZdkQVwCvVrfXcQ7ObPE6WquPtOBaEeoSI4yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logarcheon.com;
	spf=pass smtp.mailfrom=logarcheon.com;
	dkim=pass header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=hTvAVxYB;
	arc=none smtp.remote-ip=185.70.43.23
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88A606A31C;
	Tue, 17 Nov 2026 00:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D88A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logarcheon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logarcheon.com header.i=@logarcheon.com header.a=rsa-sha256 header.s=protonmail3 header.b=hTvAVxYB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logarcheon.com;
	s=protonmail3; t=1794876847; x=1795136047;
	bh=D3F7wDt4hle7ND8YlixfMQBigLOCmZnPNNViCkmiGls=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hTvAVxYBg9lmo3B2+J42rkIyWdboKk8K386Qt1dd0YXxGMN6QxfEOY6VoP98Pe5MP
	 wVw5/g5wL+FtroyKN6N48Y9cBecTJ4u/wnhQSE2AUwmdtea+Iop5WtZTcyCEhWPYMF
	 LYKozsOT6Ysn6t9v0jNtnzFoFo56HsbNXmRv/mzOzj6vB7yWoLZ5bdlvhvddvHV5l/
	 HukoCEJrlo+ecIC3NeCw0etNYydgs3vCiPIMRn/hv3hkoW31UiGhbbFP5Nd1ejZSg6
	 3y72XtCU/CUzPfSWTAXKj1cSvtbUNKGFaRqw085llNOGFw4fGK9YBVovoB+JhE0tnY
	 yoSuFJEsmLH+g==
Date: Tue, 17 Nov 2026 00:54:01 +0000
To: Aibing Chen <chenaibing@cmss.chinamobile.com>
From: William Chuang <founder@logarcheon.com>
Cc: Phillip Lougher <phillip@squashfs.org.uk>, Andrew Morton <akpm@linux-foundation.org>, wangxiaolei01@kaihong.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot+5d7ba5f6127ed887f459@syzkaller.appspotmail.com, syzbot+7b1d0ea11475e857d063@syzkaller.appspotmail.com, syzbot+d8a69701a6e796ad5d3e@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] squashfs: return -EINVAL on invalid directory inode size
Message-ID: <20261117005352.48227-1-founder@logarcheon.com>
Feedback-ID: 145408520:user:proton
X-Pm-Message-ID: 7021bba8452a88e0e5c6ac7d0ed92c19f6384c58
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Aibing,

Two more open syzbot reports on linux-next 84abb955b101 have the same
root cause as this patch: the two new "i_size < 3" checks in
squashfs_read_inode() reach failed_read with err still holding the
positive byte count of the inode read (32 or 40).

  kernel BUG in vfs_get_tree (3)
  https://syzkaller.appspot.com/bug?extid=3D7b1d0ea11475e857d063
  (mount: get_tree() returns 40 and fc->root is never set)

  general protection fault in security_d_instantiate
  https://syzkaller.appspot.com/bug?extid=3Dd8a69701a6e796ad5d3e
  (lookup: squashfs_iget() returns ERR_PTR(40), which IS_ERR() does
  not catch, and d_splice_alias() dereferences it)

The second was filed under [lsm?], so it will probably stay open
unless the fix names it.  Whichever version is applied -- this one, or
"Squashfs: return -EINVAL when directory size check fails" (cc'd),
which changes the same two lines -- could carry all three reports:

Reported-by: syzbot+5d7ba5f6127ed887f459@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D5d7ba5f6127ed887f459
Reported-by: syzbot+7b1d0ea11475e857d063@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D7b1d0ea11475e857d063
Reported-by: syzbot+d8a69701a6e796ad5d3e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dd8a69701a6e796ad5d3e

For reference, a CBMC model check of squashfs_read_inode() as it is in
linux-next returns 40 for a long directory inode with i_size =3D 1.  With
this patch applied it returns only 0 or -errno for every inode type,
and squashfs_lookup() then never hands d_splice_alias() an inode that
is neither NULL nor real.  Harnesses and outputs:
https://github.com/williamchuang/linux-kernel-contributions/tree/main/squas=
hfs-lookup-errcode

This analysis was done with the help of an AI assistant; I have
checked it and take responsibility for it.

Thanks,
William


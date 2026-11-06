Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947641;
	b=mesM0XO/evmmUJeMJ3rLf0VJeLXTpG2G1FZ9ObJ/s85Hgdkj4GnAsc0xTnXyb7ViIOSk
	 j3NQlG9qdxbROBVqk3kfOw8VkX/+tmU0uWjbl7eAWcJ8JElcq8ZWtqOxfZcQrTqljyY8x
	 Kj3Y07vMt6FTIP4yeax4iHnJKJehmRNqEbtDq2q3WdFFaXtjkPp4606SswhBJP8t24Z1c
	 cKor/WDX0QHRmGGaPlde1GIO+8yK+HMMQazq+9GqxGipkXNJoS8YSRHVaqpz8eUm7QtDu
	 SBukK9+JJ/+p5GhMMxTvsS2M6oWvrwl5vYH3P5wdi3AQ2FGxDRb+24pmxVjdBTFDRTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947641;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lFJ4Bk9Szd6iDcz+AwPPa8L1TNNV0r9ZDRnxCUcLem8=;
	b=YNbmw29G4kHi8Ywm4Ip/E7JPX2N4sP6DkExYycN+CYhRsd1fn6+EDW04R+7p0QhYeGhu
	 TBKlgo8zrvwT9qDWqKSu0aflQpc/hxiG2KLR8k8+qsrMYdubD3Oh/El0Gd/ytW1ZCzyB6
	 /G1kD1PkDrGWe4w87ThrlRen7g+znbWcl0Wxa/sDIG/FGFCRkVfC+cDo1a8wx3MT2vm3p
	 6TWGju+UcpqiWAfoVnWhL+vm0NpMkfxmdxmrfxs89/X1mtoM7jhA5n4V207BigX1TrKt7
	 7m2Otya8HTbSPBkTwJXr3XgS5EqFDCIiP23ykBXvK6UYQ6nkuf/hBNUA9taGhgMJRBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RfaMmIe+;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC6606A326;
	Fri,  6 Nov 2026 06:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17AC6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RfaMmIe+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793947633; bh=lFJ4Bk9Szd6iDcz+AwPPa8L1TNNV0r9ZDRnxCUcLem8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RfaMmIe+ywMbLXca3R2UmGDrQQ4eTPzogG/LdFGJrLN8UVh2f5IK0NcfK755UGK1C
	 i9HzzPlcPZwmQ6e58CxSvUlL4MFlLTHazu7mRJ7xJ5tUeNrp7x57X8IRz2e1huqugK
	 G8Wivl6jFqJ6f96gCf7F3finxVv/86qJTIAUvieA=
Received: from shuai-VMware-Virtual-Platform.. ([218.28.192.28])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id BC20A2BA; Fri, 06 Nov 2026 14:47:02 +0800
X-QQ-mid: xmsmtpt1793947622tuse42h1u
Message-ID: <tencent_29EE4AD2892C62F20E4D49B8626246134B08@qq.com>
X-QQ-XMAILINFO: ODQfruXGvXmaI/SBdJ5Rlb2p6UcDTYznVkHqvapaL/Ytc5q6HIAS/J2QRzAEbz
	 DHedU4gIZyHitD641FzBJkJBW2Pr8TCFN0ogdcd+kPrEZhFy1ud7TXu0DdIPwK/YInFV0KoIZpK6
	 uwHLb4GO9apQels8qOFSRXYPmsTT2d7uraTV71QGYGsdRl7NFQlkFfodq7y6ieEBB0ctwzohhldD
	 a8CGeMeRHBEBLd8T2HMO+hC4zFTnl9EXsQ8R5wG+JUAAJVuNaZIeST++AjSosVFvtgSJyvhP+GaP
	 NvE+ZYsozA/4tgrerGBn7u36WDAhDQZTc6FZud/eEkil3S2nEcKWBSwsurkVdJ+6M0OOFhPYZh+S
	 Q5fwrVd/LSIyxCbACj+Ukg0WoqiCbtjAUmJ9YsB3edIBXt9z90ZlvXJIj8OUnogbyD1m8Qqb5dRF
	 1TBeIfMJGs1IYkuCnVLVXuGDmLuz22bnxDmG1zisfUXJbNenoU6TCEvFC9ddsbOhd3Aye+TTI743
	 FIpC5pGXQHkZFfpZ3Mb8xAip4fq53sAzQSyfs5a8j18LGbVy+lqFgolvNBMFlgZj8hywYN9IGrAY
	 yZ3Eo/QKPEkN82u0+XhZY+Qy6OLG6UVtMRvtgBzrBiz3NQVd1AN9FmvRdzxkIRh40mHX3WdkuIvz
	 Re9orkvjHK5lKGG8gTMcbrFJ8514N4e+NZD1eqwLpXbgCm57IPIkKcshViIBCxq8yiw5/yzcT6dz
	 /jn7eGb6vLgkasHwr8sCQbvnrvftQvl1nWS8DSAPGHUFpiy1Ynzt6l+CYoLMuxgjJowC6BdH/zn1
	 krgviNH8I/IQ6CEW2YystvKKtPyC0EJbQea60N4PYNfl+nbcX5NkqXCz8AbYp4qGVwrvy5Z1TFN8
	 CHdRM1OrZkQpnfH/VJ3LAU3u/Il8zHu0aMZLF9IWY3froBIkFfWO2+6nsDprvYAnxypcd8gtUPCl
	 lC81dE2FVfWcikxLKkGCxIUsLPRhuJATAY7BgwHeAGhJZAwJQdF/bamMYFE7+vXwYm8MfxGSgFsr
	 ajIhYV8Flzw2CW2BzytqsrtfZNrxZzXBCpbJstqZS0oecZVSnXDkSXkqDzvrxDpfV2pxswWklUY3
	 qsgJexRZWygzsQTzzYZegoZP8S4lOaP+xdyXR8
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Shuai Liu <847807867@qq.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	neil@brown.name,
	brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	syzbot+2ed46b6b748df855347f@syzkaller.appspotmail.com,
	Shuai Liu <847807867@qq.com>
Subject: Re: end_dirop() can unlock the i_rwsem of a re-parented dentry on PREEMPT_RT (DEBUG_LOCKS_WARN_ON in filename_symlinkat)
Date: Fri,  6 Nov 2026 14:47:00 +0800
X-OQ-MSGID: <20261106064700.525802-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_EE9EBC53933F6E9658D6848B7B89F4370B06@qq.com>
References: <tencent_EE9EBC53933F6E9658D6848B7B89F4370B06@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Al, Neil, Christian, Jan,

Adding you to Cc on this -- my first mail in this thread only reached
the list address due to a sendmail mishap on my side.

In short: on PREEMPT_RT, syzbot reports DEBUG_LOCKS_WARN_ON
(rt_mutex_owner != current) from inode_unlock() called by end_dirop()
via filename_symlinkat -> end_creating_path() -> end_creating()
(syzbot dashboard: https://syzkaller.appspot.com/bug?extid=2ed46b6b748df855347f).

end_dirop() re-derives the directory to unlock from the current
de->d_parent, while start_dirop() locked the parent it was given
*before* the lookup.  The warning therefore implies the dentry was
re-parented between the two.

I audited the candidates that could move a held dentry
(lookup_one_qstr_excl/d_lookup; d_splice_alias_ops() both branches --
IS_ROOT __d_move under rename_lock, and the __d_unalias path with its
s_vfs_rename_mutex + inode_trylock_shared()/-ESTALE fallback) and
could not construct an interleaving that re-parents the dirop dentry
while the exclusive parent lock is held.  Runtime instrumentation at
both ends (owner check in end_dirop(), parent-identity check in
end_creating_path()) ran ~48k iterations of the C reproducer with
zero hits and zero false positives.

The full analysis and my questions (Q1: should start_dirop() capture
the locked inode explicitly for end_dirop() to unlock; Q2: which
d_move() callers do you suspect; Q3: could the divergence originate
at start time) are in my previous mail in this thread.  I'd greatly
appreciate your insight, Neil especially given the start_dirop()/
end_dirop() rework.

Thanks,
Shuai Liu (刘帅)


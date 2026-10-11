Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB7F13B5B3
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757084; cv=none; b=r/zqBawWTlblcsz0va2tcmTL7pPtBA8zCaOyu2BfgC48kbgB/ju7muPEke8GbO/5mUQNtraTHPUwELsvVivnxNEysgtlRxEQDzS+tbiC5cn3aWOWbFz+LYZt5EORI6Oe7JHPXtSqTbeeYy/kfsI1W1h2pEqWTbMrtpT56kFm1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757084; c=relaxed/simple;
	bh=rnNStryNTGVZAeJp7OPkxubE2+1Ji8/5qCigHYn8GWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLC5PLLjb80m8ToEhyT5E88xRVGQQfvjTzcCx8W4f2r88gOOMW5v0LyIbgZ23A0x8WCQieBoXdqwq3oJU3RWnb9HLxxDDYV160PjnUOrTemerXB65g7UsinT8leJGY2Zs4OQWqcD9J+hFLjlcUQJHz+48ndH1KJ+CzHzWoSg03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wamye5Az; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wamye5Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396851F0089C
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 22:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791757082;
	bh=rnNStryNTGVZAeJp7OPkxubE2+1Ji8/5qCigHYn8GWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Wamye5Azwj5oVOghTNQfHMSUfJ47DeVB1jflkpTwWpQ6Z3N6ziToQkz+Nwn9/3wO/
	 G5+g8MRYXezB0YnUFTGi0Zmy+g94k1wfD5J6K6q28s1C9NNWDlaBZc6vb70NTrez+O
	 7LSfuoyZFyhEOIRjXNsCdzwaSAOoNUiyiGOIqUHH4TxTfgneoV3wWmlN/+Ng4fEfzD
	 qgiPzuClnA1hMEcBvPmEL/OE2dn5eoqP5gCVp0bNr423WgI7KpAOvTeMD7v/RXzM3v
	 bY4wIA4iB8GDKrIxBSw8r2Nka5qyyRU7m6WmDNDO+gZyQ1t1UKebfyGXJz0G+CKieI
	 vpp+e8wBmIHgQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2055573c8cso153702066b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 15:18:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxkok4xKpXQudoMfbWEaff+UoY2AWO8v5x3HWXEK3xgqCTUUPMa3e5OJjqqP/Yyu6eZjZk0TaQR2YM4WcRl@vger.kernel.org
X-Gm-Message-State: AFq9FYLjhB+dBtpIRrPAU1kUc1kZUXjyUkKUHYV1yKi1fXj3Uyc09bDX
	s5LBbXph92UuU0H3WwDN0+Vf3hJGCKjI5B5bg64Go++co5DH7sBUhAhM5IZxHYNgRoSOQTz2iT0
	23fbNcPPq52e+kidHKbkqS4yHl1EMaO8=
X-Received: by 2002:a17:907:8692:b0:c2e:2720:8f68 with SMTP id
 a640c23a62f3a-c31aa01b41fmr700438266b.46.1791757080557; Sun, 11 Oct 2026
 15:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <010001a1222f66ba-0c745f29-d4fe-4862-93ff-1db2055b05fc-000000@email.amazonses.com>
 <CAKYAXd9EkVrdKjsmcd96OFc7pf=2WA8KMUBhRPZROkUOdkV=SA@mail.gmail.com> <010001a1273da435-1b6e4385-3185-451f-821b-8d8723ba78d3-000000@email.amazonses.com>
In-Reply-To: <010001a1273da435-1b6e4385-3185-451f-821b-8d8723ba78d3-000000@email.amazonses.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 12 Oct 2026 07:17:47 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_2nx=EmTYdH1t76KuRzJZw5Ln75ZQepEvNGn-46f5+dQ@mail.gmail.com>
X-Gm-Features: AclHuK_6HzT0lWvDRIo4hmLdpb1qADFCHsjTK2KvGuYlyDQteQt66fSMdtGSres
Message-ID: <CAKYAXd_2nx=EmTYdH1t76KuRzJZw5Ln75ZQepEvNGn-46f5+dQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: clean stale bdev buffers of newly allocated clusters
To: nfalesy@gmail.com
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, hch@lst.de, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 4:15=E2=80=AFAM Nicolas Falesy
<nicolas@nicolasfalesy.com> wrote:
>
> Directory entries are read and written through buffer_heads of the
> block device. Removing the entries of a directory dirties such a
> buffer. If the directory is then removed and its cluster is reused for
> file data before writeback, the stale buffer stays dirty in the block
> device mapping, and the next flush of the block device (fsync, syncfs
> or umount) writes it over the new file data. The file silently reads
> back with one sector replaced by the deleted directory entries.
>
> This was harmless while file data went through exfat_get_block(), as
> __block_write_begin_int() and do_direct_IO() call clean_bdev_aliases()
> for newly allocated blocks. Since data I/O moved to iomap, nothing
> drops these buffers any more.
>
> Clean the aliases in exfat_alloc_cluster(), once per contiguous run of
> allocated clusters. Doing it at allocation time covers every path that
> allocates clusters: buffered and direct writes, and also fallocate()
> and an extending truncate(), which allocate clusters before the data is
> written, so the later iomap mapping does not see them as new.
>
> Tested on the exfat dev branch in a KVM guest with a reproducer that
> removes the entries of a directory, removes the directory and writes a
> file over its freed cluster: buffered with and without fsync, O_DIRECT,
> after fallocate(), after an extending ftruncate(), and with the freed
> cluster in the middle of a fragmented allocation. Without this patch
> every run corrupted the file (55/55); with it, none did (0/55). A churn
> test that creates, removes, preallocates and truncates directories and
> files, then runs fsck.exfat, is clean with and without the patch.
>
> Fixes: 82a81a7352bc ("exfat: add iomap buffered I/O support")
> Fixes: 867b9c96dc83 ("exfat: add iomap direct I/O support")
> Link: https://lore.kernel.org/all/010001a1222f66ba-0c745f29-d4fe-4862-93f=
f-1db2055b05fc-000000@email.amazonses.com/
> Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
> Assisted-by: Claude-Opus-5.5
> Signed-off-by: Nicolas Falesy <nicolas@nicolasfalesy.com>
Applied it to #dev.
Thanks!

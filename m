Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB833CF020
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648534; cv=none; b=UFxTkuqHnkeGYJk0mUzc/HQ7l5m7mCB///80HS4Q3UsViqhfZhpsOjk1vxYMSvthL5xxpu558K+fleCZP+rA9DTGgW6qMS6JCnmmWcbAma6qvqBKM8cPLR4q+8C2a200z/lPkGiVOkxMhd6hIjZ4RiK6ikEWvqQSytlOr86SJWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648534; c=relaxed/simple;
	bh=lDo/awf12mnu0rXStjbYUQ5yncxlrbhWIgSdHpfq9pY=;
	h=From:To:Cc:In-reply-to:Date:Message-ID:MIME-Version:Content-Type;
	b=kyQieGZ08YzRgCNjgXyIFscvAZ+g/l3CCJUAhUxKIGV/X8bc8BZQRP5Y9P20D7G9QBLvd3zt+PvjqTujAyWGuo08t1DgbpnJcRrnDIL9bsOpSwSWrEXBcikct1ICcuFj8/1+FC3N0lJJrGXaUVUJ3BFtNnu/rdqR8ExN060vKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuJHVdp3; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuJHVdp3"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137dd5161feso2789804c88.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780648533; x=1781253333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :in-reply-to:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2QbVMMAjVZgPuV1Q0/veKQfSmVHwoFIoMdSdS/WIZg=;
        b=UuJHVdp3tKhT6AAQPnN3VH1SLaVTVJeu9SdL+rDlZeBP0FpYsKaAzlFGvx4DYEk3ec
         UQdgbwulJIOzWNqwVGUuJvQ8K2YgSPJLo/xG6GnBJJ7/poxarU2Hn4YkfmRrpebC5Hc+
         y916et1JSExata7ER1hp+anPEwNXQj9sDI7wcjqNcuHc+mH1D/Wgt33Ml6EjQJCeF9Xm
         7xarHNEU2SmCDhMUHqcdzPnllKDv22SGRMmGBxjG5H3yTtUqnS0UHERJjLPovZ95EG4V
         SqRCJF1eHoo9DiCFdI4pmZzCtVn6A0zo5ld2MaJRhZHsMShrfGoHBetyL2/5Mlybmpj5
         /qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780648533; x=1781253333;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2QbVMMAjVZgPuV1Q0/veKQfSmVHwoFIoMdSdS/WIZg=;
        b=quDgoKKpmJFYc3kO/tgxjiMnY2gX+d7CLDB2ynCD4j7HnBL5C4yxq8X955K+A5z/nL
         dRW5eQ99YaAvumrCFaaqR7WwtFCBssZILY8H+EstnQ8fVW8vp6rfgp9aXrApUyAy3qOU
         OszMa1v2I+8V3uFVfResyLdTzvVl7hupdybaG3Vo4qPvG/hOnx4LgAOz6DsgGdNwt1eC
         2NKWDrNYNvZZOZPEOFjQ38no91UI4GqE7BzelaXjfW1MOp7pXRKGf7GKlzsgCD9/GhVn
         8SBLnV7pSX+jSIICB/cQ7f8MuPoaR+iTyJLQKQM6icQyE5sKGB3CY0s1SSfMpjk0K5oQ
         UWGw==
X-Forwarded-Encrypted: i=1; AFNElJ9NLbsa9gSfHnvFASb37ojVyn2zsqwHBjecDH39YKEwc2N5ET2YFmTMET8Zffhf1D4qhB4+3qdnKyZBPMzG@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9AqsGltmNIVvhsQkoLxcZV/oSjI7bC/8UOVMTG/sYoAOGwC1
	CEPmGX0T2ywe9GUTJsWPmXLd0lRRz/UrxmhPRex/r6qC6f6Vrwa3cQzb
X-Gm-Gg: Acq92OH6njVU6x3Rta7ZvgBAUffl7zXFK4O6A8p6etc2uNsCZk6+oBeEGIYj/CMJBNm
	j8tOTL8JCHfIfz5uu48xII+FA74pYaanonav0ZVlmYASVlhkvTCBFbYrVVsTsCrkbT6dGiVL5AS
	Vnm3bTwEQS/xMHioaQidEaCKBcdXiQkBo2meXsep+DaEhR7tWRSFnmNR98ZjdPA85UTAth+cbFx
	6J15RLaxpT87YE1XApCd9Ps21qmhCWjFaFzLmEj8AplXm5ycnsxZpBnrT0ZYVduPEHq8/sBSErm
	GVwIdIHwlNkYIYrHoDEX9lt9v+LFtO5ZatQQwsitAwfPUBAMy4z7HSCGtnd5cdr1EDDjuoKcNIK
	O3EDAeA3hNL8u0S0U4cuIUa6OmPZJY2eFl3xywIYX8G3P+vnBCpZriO5h7Tvqj43eneT2VHi3vQ
	cnEkICyK+OgpkJQoNg8OFRZPaL1QqLlpugXQ==
X-Received: by 2002:a05:7300:72c9:b0:2ea:5057:a304 with SMTP id 5a478bee46e88-3077aeed2fbmr1184583eec.2.1780648532644;
        Fri, 05 Jun 2026 01:35:32 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770:10ff:fc71:c346:9948])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba046esm6534100eec.9.2026.06.05.01.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 01:35:32 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: brauner@kernel.org
Cc: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>,
 akpm@linux-foundation.org,
 axboe@kernel.dk, david@kernel.org, dhowells@redhat.com, hch@infradead.org,
 jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu,
 netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de,
 safinaskar@gmail.com, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, willy@infradead.org
In-reply-to: <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
Date: Fri, 05 Jun 2026 01:35:29 -0700
Message-ID: <87tsrh8jvy.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Christian Brauner <brauner@kernel.org> wrote:

> On Sun, 31 May 2026 01:01:04 +0000, Askar Safin wrote:
> > This patchset is for VFS.
> >=20
> > Recently we got a lot of vulnerabilities in splice/vmsplice.
> >=20
> > Also vmsplice already was source of vulnerabilities in the past:
> > CVE-2020-29374 (see https://lwn.net/Articles/849638/ ).
> >=20
> > [...]
>=20
> Applied to the vfs-7.2.vmsplice branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.vmsplice branch should appear in linux-next soon.
>=20
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>=20
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>=20
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.2.vmsplice
>=20
> [1/3] tee: fs/splice.c: remove unused parameter "flags" from "link_pipe"
>       https://git.kernel.org/vfs/vfs/c/a9f7db50ed2f
> [2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
>       https://git.kernel.org/vfs/vfs/c/e2c0b2368081
> [3/3] splice: remove PIPE_BUF_FLAG_GIFT
>       https://git.kernel.org/vfs/vfs/c/7d75aa8edfce

In GNU coreutils-9.11, released 2026-04-20, P=C3=A1draig Brady added the use
of splice and vmsplice to the 'yes' command [1]. Afterward, I added the
use of splice to the 'cat' command, which is now used if copy_file_range
fails or cannot be used [2]. There were some minor adjustments that had
to be made to those patches pre-release. However, as far as I am aware,
they have not had any issues yet which was a bit surprising to me at
least. Now it seems we are a bit unlucky with our timing...

Anyways, I figured you may be interested in seeing how these changes
affect some applications. I built a kernel from the vfs-7.2.vmsplice
branch and used a config based on my recent Fedora kernel.

Here is the throughput on my Fedora kernel:

    $ uname -r
    7.0.10-201.fc44.x86_64
    $ yes --version | head -n 1
    yes (GNU coreutils) 9.11.50-157bd
    $ timeout 1m taskset 1 yes | taskset 2 pv -r > /dev/null
    [36.9GiB/s]
    $ cat --version | head -n 1
    cat (GNU coreutils) 9.11.50-157bd
    $ timeout 1m taskset 1 cat /dev/zero | taskset 2 pv -r > /dev/null
    [9.34GiB/s]

Here is the throughput on the vfs-7.2.vmsplice kernel:

    $ uname -r
    7.1.0-rc1+
    $ yes --version | head -n 1
    yes (GNU coreutils) 9.11.50-157bd
    $ timeout 1m taskset 1 yes | taskset 2 pv -r > /dev/null
    [3.41GiB/s]
    $ cat --version | head -n 1
    cat (GNU coreutils) 9.11.50-157bd
    $ timeout 1m taskset 1 cat /dev/zero | taskset 2 pv -r > /dev/null
    [9.50GiB/s]

Unsurprisingly, 'cat' is not affected since it does not use vmsplice. On
the other hand 'yes' is 10x slower. I dislike this, obviously. However,
of course I realize that the average person uses the 'yes' command much
less frequently than I do, if they use it at all. To them security is a
far greater concern. Just want to make it clear that this message isn't
an attempt at getting this change reverted or anything like that.

Anyways, hope the testing was at least somewhat useful.

Collin

[1] https://github.com/coreutils/coreutils/commit/2b1c059e6a06eebbb721d010b=
1221ec54200cc33
[2] https://github.com/coreutils/coreutils/commit/457f88513a128ce91160c4a60=
f821cc1612204be

P.S. It would be fun to test this branch on the machine where we got
'yes' to output at 175GiB/s. Sadly we do not have root access on it to
install a new kernel, though.

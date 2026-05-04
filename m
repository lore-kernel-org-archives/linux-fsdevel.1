Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30921391E44
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892477; cv=none; b=e6ojMDuAhIaeOfo6ecsIJrK2l7ybnNyjAkqCDxwCHffvhDgynmOU+6bWPIwH1UAjSn8WzxmYQGAcPVB8SbaMzMCzZC3NV+0SypBnv8i3fXp1w8OIet9ilpUcZUa257xaiBzxe3+uRR8JkwYV8IQQUWZrgwJaMytGiTAqoAUgCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892477; c=relaxed/simple;
	bh=JNeOJVx+nxxbuxBSzbENanX6m294wvTCLVcOa3gQU/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjhmwMBcTGbltjLvCQBHYWNkLB5chkiwzJnf1qK6ASp94xH7214SkZpeKk/7txY1phsHBtxrXAEnQM5Es729VSzD4ti0hFlC8p0YTDIAnXSCIWKwHNSZUvhW2gtABGf1A+ItQOOc9x8kPOu5Gu4o1G3OnJ9oVB1xS3T4zdds4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3RmURdN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3RmURdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95DBC2BCB8
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777892476;
	bh=JNeOJVx+nxxbuxBSzbENanX6m294wvTCLVcOa3gQU/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d3RmURdNgnvvrowYduiLgpBe378vC2Cxtbexw7zlZ4UMf2jkRbFMlBzd7ES4/7PSd
	 zagIUFcvhP5P3Rp+cw0ryoSw1/tLiYiZOCs0oGf+wma6A0tFsdJF7bXQGSUD6zJLAD
	 tDPKNiGl5rlXjhRemGg0kjubrlhjJ8FBIgtIWCnOvdJwx6l94S0csG/tOKlwgUmdAc
	 KYgjQwuE5Rd3DDpiy/Dc7c37G798JXZxWaQ67Uk9OEi1P9iR7mLxmUpWQSEIq7fq2y
	 YRdpfmnw0INzHvHMPYFbo9FrBlHjDFbqZAUcI66Zzd7BPFRd6XmH1nZI3dahSajO9B
	 b4IBiwBRsxDgw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so6753668a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 04:01:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8tEgxVQbJNUGxGgHZxfKYtjFoPjCBuHxtYOhBUwKqKm0hYgIlFZP8Cn45+WaKH0zF1LThH4KLqg+XdghV3@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdE7TnR4domQPh9O3HQEvazuu9ENCqzcBBS98NqKuX6Y80LlG
	vQE9l0PNUzTxXQYv/Hfd1EU19MfCR30F0BDNTPHXjU4gKeNAzE0RxxT3DiW6fIG/C87P9oGsjsU
	lKTgTrUIxpx6YMHAjCkY5XVOQuJ5oqy8=
X-Received: by 2002:a05:6402:5486:b0:674:c412:6f8a with SMTP id
 4fb4d7f45d1cf-67c1b2a4be9mr3507571a12.26.1777892472066; Mon, 04 May 2026
 04:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777568957.git.charsyam@gmail.com>
In-Reply-To: <cover.1777568957.git.charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 4 May 2026 20:00:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9EmJ4wFUb2CkuiynBCgm75MLVpquaVZniowZoqq-DZ+A@mail.gmail.com>
X-Gm-Features: AVHnY4JZpWUUxIRBkl_d5ZTmBWdlR5H5xuHAFVBPZUJ7YToz5dwPHgp88EIHJDU
Message-ID: <CAKYAXd9EmJ4wFUb2CkuiynBCgm75MLVpquaVZniowZoqq-DZ+A@mail.gmail.com>
Subject: Re: [PATCH 0/3] ntfs: error/durability fixes for mft writepage paths
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 2:21=E2=80=AFAM DaeMyung Kang <charsyam@gmail.com> w=
rote:
>
> This series fixes three independent issues in the ntfs mft writepage
> paths in linux-next.
>
> Patch 1 restores the documented synchronous semantics of the @sync
> path of write_mft_record_nolock() and of ntfs_sync_mft_mirror().
> Both functions claim to wait for I/O completion, but in the converted
> bio code they only call submit_bio() and return; bi_status is never
> inspected.  As a result write_inode() can report success while dirty
> bytes are still in flight and bio errors are silently dropped.
> Introduced by commit 115380f9a2f9 ("ntfs: update mft operations").
>
> Patch 2 fixes ntfs_write_mft_block().  When the per-call allocations
> for @locked_nis or @ref_inos fail, the function returns -ENOMEM with
> the folio still locked, which stalls any later task that needs the
> folio's lock and drops the dirty state from the writeback iterator's
> point of view.  Use folio_redirty_for_writepage() and folio_unlock()
> before returning.  Introduced when those buffers were moved off the
> stack by commit f462fdf3d6a4 ("ntfs: reduce stack usage in
> ntfs_write_mft_block()").
>
> Patch 3 captures the return value of ntfs_sync_mft_mirror() inside
> ntfs_write_mft_block() so a $MFTMirr write failure during writepages
> is propagated and surfaces via NVolErrors.  Patch 3 is what makes
> ntfs_sync_mft_mirror()'s newly-meaningful return value (from patch 1)
> visible on this code path.  Also introduced by commit
> 115380f9a2f9 ("ntfs: update mft operations").
>
> Note: this series does not yet wait for the main $MFT bios submitted
> inside ntfs_write_mft_block() to complete, nor does it propagate
> their bi_status, nor does it redirty folios when records are skipped
> by ntfs_may_write_mft_record().  Those issues require a per-folio
> writeback completion context and are the subject of a follow-up
> patch I am preparing separately.
>
> The patches apply on top of linkinjeon/ntfs-next.  Build-tested on
> x86_64 with CONFIG_NTFS_FS=3Dm and pass scripts/checkpatch.pl with no
> warnings.
>
> Runtime testing was done in QEMU with a small initramfs, ntfs.ko and
> dm-flakey.  The test kernel used CONFIG_NTFS_FS=3Dm, CONFIG_FAILSLAB=3Dy,
> CONFIG_FAULT_INJECTION=3Dy, and
> CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=3Dy.  KVM was not available in
> the test environment, so these runs used TCG acceleration.
>
> On the unpatched baseline (the commit immediately before this series,
> 9e9354075d5a), the QEMU tests reproduced the fixed failures:
>
>   - With dm-flakey erroring writes during a metadata fsync,
>     utime_fsync returned success:
>
>       QEMU-NTFS-ORIG: TEST patch1-original: BUG reproduced
>       fsync returned success under write I/O failure
>
>   - With failslab injected from the ntfs_mft_writepages() stack,
>     sync stayed blocked after the injected allocation failure and the
>     guest later emitted hung-task diagnostics:
>
>       QEMU-NTFS-ORIG: TEST patch2-original: BUG reproduced
>       sync still blocked after injected allocation failure
>
> With this series applied, the same QEMU test setup completed:
>
>   - The metadata fsync path returned EIO under dm-flakey write errors:
>
>       QEMU-NTFS-BATCH1: TEST patch1: PASS fsync failed as expected rc=3D1
>
>   - failslab injection from ntfs_mft_writepages() was observed and sync
>     completed without hanging:
>
>       QEMU-NTFS-BATCH1: TEST patch2: observed injected
>       ntfs_mft_writepages allocation failure
>       QEMU-NTFS-BATCH1: TEST patch2: PASS no hang after
>       injected allocation failure rc=3D0
>
>   - The writepages path observed and propagated an $MFTMirr write
>     failure:
>
>       QEMU-NTFS-BATCH1: TEST patch3: observed MFT mirror sync failure
>       QEMU-NTFS-BATCH1: TEST patch3: PASS syncfs failed as expected rc=3D=
1
>
>   - Final result:
>
>       QEMU-NTFS-BATCH1: PASS all qemu ntfs batch1 checks completed
>
> The whole-device dm-flakey run is not a clean negative control for
> patch 3 alone because syncfs can also see main $MFT writeback errors in
> the unpatched tree.  It nevertheless covers the patched $MFTMirr error
> path and verifies that the error is propagated.
>
> DaeMyung Kang (3):
>   ntfs: wait for sync mft writes to complete
>   ntfs: redirty folio when ntfs_write_mft_block() runs out of memory
>   ntfs: capture mft mirror sync errors in ntfs_write_mft_block()
Applied it to #ntfs-next
Thanks!

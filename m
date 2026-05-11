Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFFE394471;
	Mon, 11 May 2026 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506936; cv=none; b=UDu9SjCCp+t5C5OleFSfVv+jqYLH8gAF1P5kuRkg6s3PxzmLO78XtByp2gtzuE3nZptm5oudQUft6Trp9TvwOV9kk6MPz13EQiLVgUa81OkGitCxw9HLtLZoK4YcAE8pi4M/IMcxxO0e0Me601Fc2+QEJDUB7yF2cUy1ScyZqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506936; c=relaxed/simple;
	bh=U9nAzU35K1gUbCJcTJZs3I3c/ZFBVVipLUKEX80vhoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2htX3IqQRindGN/ZNMN5DYSqBHG4j+kn34CX3u2vFwWsa5OkJC2Y1sTx0sHWrISj/pOQgDoRa92rYIA4PcJSNLilQ32IcV+3cPwC60k915+tX3Siabuek8b7h+mkw9kamRQr2T0iq+zEiuKJHRmAaUovhzBkT7wj8EZUzOiagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeyFBGDq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeyFBGDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64948C2BCB0;
	Mon, 11 May 2026 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778506936;
	bh=U9nAzU35K1gUbCJcTJZs3I3c/ZFBVVipLUKEX80vhoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeyFBGDqNcJIxGk/lGQArGcsstwYzHVAUehohfgz19lRMN5iTy+j035pdbPhOs2ig
	 /+y2yifaIRrzuNgz9P325lfRNPredUGqM5AO1fIbylf4KfIkC87er/NGIiKSfSp3BL
	 sE7xKLD+Fh+ToCBq9cEzp0pfiXbh80yXYvIMGx0wjaYhQ31Uow+HOydklFmitLdwQU
	 lwiSUCwqnSUGX9F9Yh6OAktJg7+sgXsQ/k7C4YbouIIn5tDrDLctvLf1ZN7wWqBCYh
	 2p/4ccdQx6WXHEfTH9tDjcWuCaLKR24gPDzYdWfhMWHIL3MsdgnNNwARAT3QLndqDj
	 kkNWDR+X7KCoQ==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Bob Copeland <me@bobcopeland.com>,
	Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net
Subject: Re: fix crashes when mounting legacy file system with sector size > PAGE_SIZE
Date: Mon, 11 May 2026 15:41:58 +0200
Message-ID: <20260511-sporadisch-kopfhaar-12f7d430885d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511071701.2456211-1-hch@lst.de>
References: <20260511071701.2456211-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2129; i=brauner@kernel.org; h=from:subject:message-id; bh=U9nAzU35K1gUbCJcTJZs3I3c/ZFBVVipLUKEX80vhoE=; b=kA0DAAoWkcYbwGV43KIByyZiAGoB3LGjHbD4LnMeTLfcAfWHZKPtk9w/7pgimL7wi5+qkUgzS 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmoB3LEACgkQkcYbwGV43KIqqwD+N0lm xRl0tIIvQbW9urnq7Y8CuWfFlTFe5Mm8rA4HOboBAJNOp9rXwvJk/bZNLF0xfdtHOR2Asml/zMc Ms6T+Ek4I
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 May 2026 09:16:45 +0200, Christoph Hellwig wrote:
> due to an almost comical failure on my part, my work in progress test
> case failed to create any file system on a 64k block size loop device,
> and then tried to mount it, leading to a probe of file system built
> into my kernel.  Roughly the first half of the series are file systems
> that actually crashed, but I fixed up all the pattern of missing
> error handling that I saw.
> 
> [...]

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[01/10] bfs: handle set_blocksize failures
        https://git.kernel.org/vfs/vfs/c/bab288bb548d
[02/10] hpfs: handle set_blocksize failures
        https://git.kernel.org/vfs/vfs/c/765969ab437b
[03/10] qnx4: handle set_blocksize failures
        https://git.kernel.org/vfs/vfs/c/58afc2e824c3
[04/10] jfs: handle set_blocksize failures
        https://git.kernel.org/vfs/vfs/c/aa9d3b31b70b
[05/10] befs: handle set_blocksize failures
        https://git.kernel.org/vfs/vfs/c/d42cc4dfa0aa
[06/10] affs: handle set_blocksize failures
        https://git.kernel.org/vfs/vfs/c/47239d1711ff
[07/10] isofs: handle set_blocksize failures
        https://git.kernel.org/vfs/vfs/c/03f5399f6bcb
[08/10] minix: handle set_blocksize failures
        https://git.kernel.org/vfs/vfs/c/d893fc670546
[09/10] ntfs3: handle set_blocksize failures
        https://git.kernel.org/vfs/vfs/c/d5c1a645a715
[10/10] omfs: handle set_blocksize failures
        https://git.kernel.org/vfs/vfs/c/efc0b642ba34

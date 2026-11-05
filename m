Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915478;
	b=kxoyOOTU7w36QBkS9PV+WSdbFp5WDVNFZxkWmnDEfarPoPQqt1PpYwfqwrDZjD4tcO0C
	 r12GPSsj8quKY2ge3mkIUCc7+MPVltnONuh/rBcBqpGBKIQo7N4hzTpCU2Nd2TNszmFgA
	 /+gjGWQ9RXMGMPEldajAGDVslcF7N5ZGGOllDaeyvOU0t/QrPsRROMNrmry3/knfzbFmT
	 yt54uKr0MA2ooBF7MDBpdz6lcjZJ8benBR6OdcXn3iOV1FlFIbiayfQ8wcll08gH7+7N0
	 vyVanXlzH2R2UwwQX05H3TTRX+mN8MTzWFETuDpzm08eoiWqnhTiMhN0MqKkjfalZdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915478;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=lCJwq0iZVmgcwQ3/Wg9SbCgf3RZUlL6CyJhyhFKIkbU=;
	b=iMSSTrYOEOJ52axfNIAokoNdWzXPngdLVU+4YYn2OdVBf8qEP1WH57o8+I2OauWaFNjm
	 azIAiMUgqh/AwqTX6/6jHybOyAvW4mJDexupehQXHY0kPg60EkJg118Ya8uy1NeM+MopA
	 KkcSZzHrfexuYC+6fKZ3Y156BDfmo9j03RebsvsVmMbhEBqxqxvYLGqvGeuLgTnBUEYbI
	 pMKhn4KFjdvVWeH3rU4DtMQQftgmF9CIQsTM6c1A4XzHj3g/0EsfIltP5m62xMyzQeJWT
	 fndqXKdyFY/tlOvTCjYFbTml7Rcb1XD6VqDV/pCMaEygB3KRhRwGhpn7cByX//LCTOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8nbhwS8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9659F606A31B;
	Thu,  5 Nov 2026 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8nbhwS8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B821F008A1;
	Thu,  5 Nov 2026 21:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915478;
	bh=lCJwq0iZVmgcwQ3/Wg9SbCgf3RZUlL6CyJhyhFKIkbU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=h8nbhwS8nzg5GTVbLeZvMQYmR6Hq3g6/Ke1MfR85+bNkRP0KREXzRRITHYLqb436d
	 3PS2L5mlFpIysDobo3+GFJZPiLFJ/UcKCwm3ueiVemkdqOj38A/rEtRYJqTdbn+glh
	 9h/TM7Dc+vR6xv8w2xuF5G5w66vOsBYEz7803Aa+pxINGWGro9dU11LjbvskubDKn4
	 2fH6cLx/cUc7SVuJZg42R8ofxvnc8g2wU0sT0v/KEWt0Ikm8OITZIKUXJ+NYXEhVWn
	 Xpr1/eO5zLkWYMuVgHCG+s1X/Q9J5AXvZqoN6n0ZHXvh0yI2Ciib7eb+oPo97lyfom
	 TZtZSJ0F9Y0eg==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Mani Tofigh <mt4022@columbia.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu
In-Reply-To: <20261027-kcsan-inode-v1-1-1ef0eb871f2c@columbia.edu>
References: <20261027-kcsan-inode-v1-1-1ef0eb871f2c@columbia.edu>
Subject: Re: [PATCH] fs: annotate data race in get_nr_inodes()
Message-Id: <20261105-begeistern-fracksausen-rabatt-96ae0175a0b8@brauner>
Date: Thu, 05 Nov 2026 22:51:15 +0100
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Tue, 27 Oct 2026 16:08:49 -0400, Mani Tofigh wrote:
> get_nr_inodes() sums the per-CPU inode counts without a lock, and the
> result is only an estimate, so it's harmless if one of them changes
> during the sum.  Wrap the reads in data_race() to mark this.
> 
>   [   11.857490] BUG: KCSAN: data-race in get_nr_inodes+0x9f/0xf0
> 
>   [   11.857568] race at unknown origin, with read to 0xff1100002b6281e8 of 8 bytes by task 106 on cpu 1:
>   [   11.857621]  get_nr_inodes+0x9f/0xf0
>   [   11.857675]  get_nr_dirty_inodes+0x1d/0x110
>   [   11.857748]  writeback_inodes_sb+0x3d/0x60
>   ...
> 
> [...]

Applied to the vfs-7.5.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.misc

[1/1] fs: annotate data race in get_nr_inodes()
      https://git.kernel.org/vfs/vfs/c/067a2ab608e0


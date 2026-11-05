Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915355;
	b=XIVXSminoOD1OG5uJgvRXoPBYNyastpE60YFRLpv6yf4CxAUt5pumyU7hS0MDRYt766b
	 k9/TcsxHGJIKMSg4VSG8zdUoaezGsszX8vaSlrVQr117cxVzF8c+h27DjBW7k+m/I9pYl
	 OvM+ci0uuXBQ3FqKs9pJgZY77cAX0pBb2eD5ON4RD78SKt7Th0m8C2/MKOhKN841uJqbC
	 UMuGA+F8LQaLY1TQw9n8kI29MHaXw6Q6iR3jVNnbWA/nTOs6sG4OS4jE4uP8us3yHRycO
	 jVEdsOPRlxmZR68JqEtBFCbMFIG+xu7qmqJc9zByQTQJ1R1qGmVXq+e5FUK5Ivix15w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915355;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=+spvOU4lJsnNXA4BybohfFNAzV+Uy6P0JGJMjSx87xE=;
	b=Go0J4PxYHF1cmUkQJctbKMWn8FkHTvLc3Yf192rI3uyzZM0Kl6tujZ1eFMSJ5+IwJpg9
	 QviCf0KP8xgQBbwhGdGUGPEN4bFA0P/xe+S4CbPztzKV7FqnGPS26NFlIOg9/1uNJqkhf
	 vs40sFt82m3Ay2iYTSppKMyshK/Z08IO1l97aMTN0sJwMemFOv/MkAEW3SnwoKfq1BpfS
	 xHc7YdJo8aFZIfCLkMRBBfIDrk9HS0X2X/eDTXnoE6YMua4Slo57Vy1CRqYmQNuh/y8Kr
	 Yd6g1UC6OOaXsiP+tMx3CQLOEt09iKkJWwhR525YTBICb5wKW1hGFVr4k3hUzcV7C/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKdFmsQE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82B606A31B;
	Thu,  5 Nov 2026 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JKdFmsQE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC881F0089F;
	Thu,  5 Nov 2026 21:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915354;
	bh=+spvOU4lJsnNXA4BybohfFNAzV+Uy6P0JGJMjSx87xE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JKdFmsQEloYY0/tGMO0zRO1hoiJKiIx32JoP4qupR2sMfOXD6wc4yR0maKIb5AVNh
	 BHQyOFLFsh5upCL/KcCvUAt21RbGAf4v65+Lmo6XTxnfD/iQDfVJXSVHZqHJ87quZ5
	 ZKX76UfkJyKXaeebo4I/C74aveGtDWIvG9FDEUxlm5z2wue9EFdtj26zJW7SFgLFNQ
	 HZ/IVxLD75VhQdvyheHHgsFlijZNkzHsO03OcMBkrAmuTcThgBU954x5y7SnfoZicV
	 cmRVAX0KdK/4gqPVGxej03EseL1KkohM2UuoKjDIuCFdWXak294s2YOnABo3mEwGgz
	 09iWaVpIG5ZFA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, apais@microsoft.com, rlmenge@gmail.com, 
 hargar@linux.microsoft.com
In-Reply-To: <20261101060049.81441-1-sidchintamaneni@gmail.com>
References: <20261101060049.81441-1-sidchintamaneni@gmail.com>
Subject: Re: [PATCH v1 0/2] fs: fix and deduplicate whence handling in
 default_llseek()
Message-Id: <20261105-platzen-reproduktion-gezogen-6ca8e87a5363@brauner>
Date: Thu, 05 Nov 2026 22:49:10 +0100
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

On Sat, 31 Oct 2026 23:00:47 -0700, Siddharth Chintamaneni wrote:
> This series fixes negative offset validation for SEEK_DATA and SEEK_HOLE
> in default_llseek() and deduplicates its whence handling with
> must_set_pos().
> 
> Patch 1 updates default_llseek() to read the inode size once via
> i_size_read(inode) and compare (unsigned long long)offset >= eof for
> SEEK_DATA and SEEK_HOLE so negative offsets fail with -ENXIO instead of
> bypassing the range check.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] fs: reject negative offsets for SEEK_DATA and SEEK_HOLE in default_llseek()
      https://git.kernel.org/vfs/vfs/c/7a5783cfac71
[2/2] fs: use must_set_pos() in default_llseek()
      https://git.kernel.org/vfs/vfs/c/1284ecd57375


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955826;
	b=i6NSeEeVAhXvnOAwm3+aYRx6AaKRAkI+hmOGnlOdx/I8zTHmQefZ+cF/8pZiB024HCY6
	 W5B6pvoRKHErpkheDQCe9cgWedahq7bVZ4ghGuVC6c4j6H1BCmq7TE+vfl/JBVPjFqjCr
	 xAUpV1S0ibZQYzmUkYX7AOTXwXKTAX7iD2hywaA6GuRVgT6GvwiRa18bwmo43u8F3nNqH
	 Kx59cGWhMbCIr8TKgorPeuAsN0CrNW+kUNTp83EU/61HLgDFIKf2jczQ6o024gkoMQJgV
	 tjFV1bHdCJHT8OPaXruOZ6fzEyl/Z9QbnrUTJs9+vvM6FtwsC2Skv+ESXUQ7q5UKCAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955826;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=GEMaa6k3b2yw1Rc+GvXN57M0QDViTmYq2ZiXe9vfmY4=;
	b=rKrSsWNUtw1E9wdrYpKACEiyGAA9EponXQnStXAaNAm5aUiyE9ENobi8idZfQxbMSxCM
	 1eJ6+7OwxW9rlZHiW09sQDKs1YNPCWBFx3eDLO2hZn4lFFECkB9pb0DLYEYq+a77U+tn4
	 /ezuL8ooHlo+gNpM33SHClf/ccsZWzQIq9FMq9sYaei+iL5qQuK8WOp/kPREBbH/xXV75
	 qvOkp5zP/mm9Feodpqw8SF+mtL2hXhrSjHY10nlLLP0p3opYCHCM8WnxVEFyrESS6SHz+
	 sc6tkYZt7ZeyZMywJ32jBb1UCB2rfYwZTBsHlCh7FFSv0dW1jO2DU71M8zD/e0Mgbvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDU+NADX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417E606A328
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDU+NADX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B9E1F0089F;
	Fri,  6 Nov 2026 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955825;
	bh=GEMaa6k3b2yw1Rc+GvXN57M0QDViTmYq2ZiXe9vfmY4=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=gDU+NADXJKHFyb7NGk5ePGmlcsW5eNQnlEnXY36hixwuMxBDPpKlweGr9FxSPzfWC
	 PFKFmk6a08XWVRwZ4qdJOhhUbp10093WoQfi3mL4xuoySIi/s5CtwVAqFcj8sCBe2G
	 6fuGGOCF4wX0HtY6tZ0ey43yCPXc1MK2japkzrcoyuYN7wSbXGnpNcnTFXi8t1Jump
	 eEu5Fyy9fRSiIZJHxjCrw1SsYuZ3wi2QXmWDtGAHuP8M2wVMIrjIlS5nQ4ED/gv/TY
	 KzjkS86jloQI3PUMHfT6ehY8XbQU+2LJGv6qlUub9g/FDmCWqikFtCPqWCA2O7v8oG
	 /jkbVe8LN9jsg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, David Disseldorp <ddiss@suse.de>
In-Reply-To: <20261105111654.214569-1-ddiss@suse.de>
References: <20261105111654.214569-1-ddiss@suse.de>
Subject: Re: [PATCH 0/3] initramfs_test: minor coverage improvements
Message-Id: <20261106-delikat-wahlgang-bollwerk-3d975b365a3c@brauner>
Date: Fri, 06 Nov 2026 10:03:42 +0100
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

On Thu, 05 Nov 2026 22:09:58 +1100, David Disseldorp wrote:
> This series adds coverage for some initramfs unpack corner cases.
> 
> David Disseldorp (3):
>       initramfs_test: drop dir data segment from PATH_MAX test
>       initramfs_test: test unpack of dir with data segment
>       initramfs_test: test clean_path collisions
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

[1/3] initramfs_test: drop dir data segment from PATH_MAX test
      https://git.kernel.org/vfs/vfs/c/fddaa75eda0b
[2/3] initramfs_test: test unpack of dir with data segment
      https://git.kernel.org/vfs/vfs/c/ada0255e934d
[3/3] initramfs_test: test clean_path collisions
      https://git.kernel.org/vfs/vfs/c/b6b8e4485c98


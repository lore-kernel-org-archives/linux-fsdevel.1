Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006586;
	b=chZeGnd2lIEsPTUbIMtyD/fbiExC4KGYYdzBUUTp2rrc8GKA+aA+DioYOc506CEjfcyf
	 cgA8ZUKQi4EwjpLbmAerJg5QOicRqW1ke+hUwI79QoDTSxKpyVw9LGnRjmpN3jdRORrxI
	 SQPRQUxWM/2KMFWdkvdKr6JmxrgT9PLnfoWYRabgJytiZ3+BDPbxjVQOHztAfvAvafBGE
	 NIomWlOQfITQOC1GQIqeolKd7h+4nCcGfKJ6LGt3CCXuWEkeEOUnzXEhcRoUdpEUYrxNz
	 iYs/woO8blc+V8i4/UIqqgAY5GIwjdAoc62vojVdaqRQS5vyj1ng1rt6fZm/Rs6wDOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006586;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=5neCEO+AjUpYkAA7CRr30R8lbLfpFguaqX0l9Y083Js=;
	b=d/aDQkQDk99KjkI22oZRCs3LEwAeNmxkKpyjUd86g7NY77p/11aaUDdSDFVsx8eRy+r6
	 JYnfR2KJuwVAGn23gvIlRNWYQSwUpkycQSRTtxoVTawxcHzUGArpixunVHA29BiXOvRhD
	 rHbrXniN0F2ak2ZtrH8XzRmmyd85sYrCQJPSrPHDHVzFnZyB4IL3hX85eYV1u3K/3ojDE
	 rQOQlb3zhgQMourTL05c5Z8qbskbB9xwMLD5eNIWtEbw0QCy1hA3FPIrJPWYORSTBVzMc
	 2Lpe6nzkJTgH3ZEsa0zfvbv1gN/DGwhGsgTP8wb7rNPOFs6NG5+JsaAtTbkvZqSDO3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pjv+k0YR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CE606A325
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pjv+k0YR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27831F000C5;
	Wed, 18 Nov 2026 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795006585;
	bh=5neCEO+AjUpYkAA7CRr30R8lbLfpFguaqX0l9Y083Js=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Pjv+k0YRYajJmPEQj7W0QacJXbQkv/rUl0iGLLF7JvF/JpQZgDyXwHOi3IhymhN4d
	 OJItomZA1TF42yOv8WIRFwqN2Hm/s/9MyTraNwzLl2zP/gnI7TnzqgMNViqQ2MRn6J
	 7AeDkJocECHi4BantFjhTOLg7ieDFNVESVdjFptekWd16pFwqN2N5+C8PeZslG9f9v
	 J/UZO2xoGcKq9o9fhwNiMKPXXks7Asupjq2b/qSVyOgInU7EG0Qvg0R3sZ3boOVShv
	 jBoKvAlFdPICBvID6g0Aok/Rb/wC+eB3vxosr7QGIkDPm3vR+ipS/QDs2bjuOMBTp6
	 X9fOREWazwpJw==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Hongyu Jin <hongyu.jin.cn@gmail.com>
In-Reply-To: <20261113082744.737189-2-jack@suse.cz>
References: <20261113082744.737189-2-jack@suse.cz>
Subject: Re: [PATCH v3] writeback: Avoid postponing periodic data writeback
 indefinitely
Message-Id: <20261118-sorten-wieso-abtauchen-cbed17cbb81e@brauner>
Date: Wed, 18 Nov 2026 13:56:22 +0100
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
X-Mailer: b4 0.17-dev-04696

On Fri, 13 Nov 2026 09:27:45 +0100, Jan Kara wrote:
> Hongyu Jin has reported that f2fs periodically calls
> sync_inode_metadata() for some inodes. The logic in
> writeback_single_inode() thus periodically calls to redirty_tail() and
> the inode's dirtied_when timestamp never gets old enough for the inode
> to be eligible for periodic data writeback. Thus dirty data from it is
> only ever written on explicit request (fsync(2), sync(2), unmount) or
> on dirty limit pressure.
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

[1/1] writeback: Avoid postponing periodic data writeback indefinitely
      https://git.kernel.org/vfs/vfs/c/40ec73e86469


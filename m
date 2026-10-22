Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674405;
	b=TR8Hg/2MTya/I++qML6GC82xVwcfdEredm+cZ5TYyNdRthmAy0l3hX74/KQmeFEOOeT4
	 pat5cysMmaIQ2U1awEX/HLr6tiMnYVqKXJGTtJn44//CZg7FGmK9wUssQoPbQ8xEQgSOy
	 H/0Z8xPlXJoWG2fEirlOOsuNwF0EoYhni86+u7Olr1e3do89NRr8k29GutAV+wgZ6w3jl
	 1cEcUun9BJ4PPghfQTT69He2MP45rkJKQK2GOl4wDuB5Ug/Dpp8KdGIAo5otrJpuw8xZH
	 SfFVQPn7uRmpD/eOOn388GtJds5gtgMgHHDhrPWXHW79JsQ9T+EYvOMnEorwAyHu5Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674405;
	h=Received:DKIM-Signature:From:To:Cc:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bwnwU5rYjaVApPDY1R+OeaLnX+sV5D1rI1i70ddm8ko=;
	b=fhOCyJrVELCBTcDbQ4xB3FNL53R5m7za8lP+L2zZzq5LeC4BPi4oMPxKvaby8LMaRdeH
	 63kOL9BZxBzOJRrC1b5EXs0DXByPACUmX532BmjDT+EK80NUEMvMuwASgl6mYusJPq1Kt
	 P+S5vNdGD9mMWzX+edbUUg0nwwFXspyZ/fH25P+vj7E5BactBNDm8W5DrZkJ+GpN9Kbmo
	 H0OGWPjcO8Q2pjCvJEZ8Ru3PWkOXVv5aQ5+azZHZs4dhWZ2F7IiYEsz39C2cnNmDw4PAf
	 +XNp8Xz3HbugGT9qywB8Mc2EMfG/ZMNc8lQBI513Y52TNxaBqGwo6nJN3N9P0Xs2VxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPd13Ive;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C538F606A319;
	Thu, 22 Oct 2026 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPd13Ive
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2A91F000C2;
	Thu, 22 Oct 2026 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792674404;
	bh=bwnwU5rYjaVApPDY1R+OeaLnX+sV5D1rI1i70ddm8ko=;
	h=From:To:Cc:Cc:In-Reply-To:References:Subject:Date;
	b=UPd13IveMy2vSe/HFnfY8W3k0mp+nEMkSa/XuUkrIVCdjvBsZFoF2ckjpxiXBBVm/
	 voa729hm8qNPWvFJQt7I72JmQFGGh6Lgt0FW/er46LdQ+iJFPHsEggtXgzDZHBoHIf
	 TM66VEB9EFHc83G1ZchVFAeC0D4E4hbdffoNbw7xboY2wX9/mJUlZzrUItav53vnlg
	 OIUY6qUNMB63O/6oQnICM0kyw6x+3C/8S5QNb9RrTq2h63n17tK40VZzj7b/Gpuu2P
	 dVIde4idCzZBKI2y+LWr/vqPIN9q8cmOZ7LW+73Ew/g5u7dRlpLTqdX96xtInI2V29
	 UqsDQowqLu2vw==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
Subject: Re: [PATCH 0/5] fs: don't let a stuck mount take everybody else
 with it
Message-Id: <20261022-gehackt-unscharf-neugliederung-0f5691b3a177@brauner>
Date: Thu, 22 Oct 2026 15:06:11 +0200
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xl7J3jxIvVE51xp4/7iYovq/Hbs3GdLm4/CkZk99kbI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd4krcqZ56k3312uIo1o6+47MEozZPfXsh/O197dsf7
 lkunzTVsaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiz4QZ/sotUYppPx7UZf9d
 z6u65eCPCWvlfv2N5Npztbvze+zsHWsZGc60bN15muuR1sfU2o1zDtqKFuxer5ayOqLaYA2/jHp
 kLCMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Wed, 21 Oct 2026 16:46:56 +0000, Josef Bacik wrote:
> fs: don't let a stuck mount take everybody else with it
> 
> Hello,
> 
> This is the follow up to the stuck unmount series, and it applies on top
> of it (vfs-7.5.super).
> 
> [...]

I resolved the merge conflict locally. I'll massage the helpers a bit
and get a patch out in a bit.

---

Applied to the vfs-7.5.super branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.super

[1/5] fs: make a mount waiting on another mount killable
      https://git.kernel.org/vfs/vfs/c/c1d254f3c8aa
[2/5] fs: make ustat() and quotactl() killable in lookup
      https://git.kernel.org/vfs/vfs/c/d88c310d4e27
[3/5] fs: make BLKFLSBUF's wait for a superblock killable
      https://git.kernel.org/vfs/vfs/c/e7c9543797a7
[4/5] fs: don't make sync(2) wait for unborn superblocks
      https://git.kernel.org/vfs/vfs/c/3924b255e480
[5/5] fs: skip unborn superblocks in drop_caches and Q_SYNC
      https://git.kernel.org/vfs/vfs/c/02303f78a82d


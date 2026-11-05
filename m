Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894995;
	b=I9WxbnvostI8GAU4phGEe3+POo7CsIGE+9f3G3s/4APOA5i4N+/rGMknJ17xQkvbLj9M
	 xjm61ZRGh2BSY5/8BI9Qd/3gkcz3n13tvw8+jUu3N8lU/Pm6JfKQ06uX/v15wNrYkn7q+
	 HEikvNW0Q8Y9HZI79KwsHmNMipeCP36Kin5/JhpEOwQ2H5OaJxFqjozTnoqgmOqDyzawQ
	 qxECJRWqnMKEqS+lYL3l/JAEWdeQCW7OxZJfXKcqXO1ZI2NboKipjTytd9dtFoJgR7ifp
	 wXzG8QUYS0vm0CDBAkAyeYDgYgiyrZqs8W6Zr8uJzavPO9H7SwRDPBmMrMMfMeIHEkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894995;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=OSTCfs2XzAvk025J6lARxVK0zzuzsUUuB+NCb52rlvM=;
	b=KzSGcEn7A2+oXZjFVH3KLv0iD5SrT8gIlbX1Ne3QQ//opQNPjkqTLuTwuvHlEa7Shom6
	 Obco1g0LmUZEA8KrDv9GEY4VTj+KBZIzi8mkH+Cx/9Me+fhDTYPW682L9RkmKcKh8CwL2
	 YLKI8GYTvF89JgyzwBf/g38TKWrTX04nkz3zukzAiXMwUV+n4bwUk4ZQzFhLIMG5WAWG+
	 SHO/niGfK2q66a86SSVhj89rl9+2kca4wBdHkHFYrY1l0/9MCS92D+OFjbGsa1Nlqj5HZ
	 2ve9BzZUXZ4WBjbrxcmHiZg9FKac36MEx50yG3scQ+H6rVOAKA9eNeBkEN3VbE35Anw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCS29VHe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59207606BEB1;
	Thu,  5 Nov 2026 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCS29VHe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27FB1F00919;
	Thu,  5 Nov 2026 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894995;
	bh=OSTCfs2XzAvk025J6lARxVK0zzuzsUUuB+NCb52rlvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GCS29VHeSfqBwiD7+T/mJS0G1T7l93vXoyme+0hV6f6/ESQCxnLUgdPybJbhb2AfA
	 +2NihJkrjQmIhWmjdQJPng8pimlxlhwYzfaCf3p1O5XF28K4RiDVM5pm7hAdFkHcld
	 frhUs1iH3z/Hl0wIdlxUWc0AolJ4FLtvhYPCb/s1mRkn1+ZtdStj3d8iWZKBCp1yPw
	 Mtb22lPn7uNJY43+9rGh+zeGz9QekuXYoDSO+SO7uykrmw5e3M1cOwXbNuc7Fn6Jiz
	 5696A8QLVlO/LweVUHzVHhC4T+Y118mrXM/7CXMAzsI7kaijnAglz4VICOe5Tm7xpI
	 DslPJAamhoEHA==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jan Kara <jack@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
Subject: Re: [PATCH 0/5] fs: make the system calls waiting for s_umount
 killable
Message-Id: <20261105-prolog-beteuern-mahnen-85aec53a5e7c@brauner>
Date: Thu, 05 Nov 2026 17:09:51 +0100
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

On Fri, 23 Oct 2026 20:39:29 +0000, Josef Bacik wrote:
> This is the next step after the stuck unmount and stuck mount series,
> and it applies on top of them (vfs-7.5.super).
> 
> Those two took care of the two ends of a super block's life, this one is
> about a live one. s_umount can be held for a very long time. syncfs()
> holds it shared for as long as it takes to write the file system out,
> and on a slow or dead device that's forever. That by itself doesn't keep
> other readers out, but as soon as somebody wants the lock exclusively, a
> remount for example, that writer queues up, and every reader that comes
> after it queues up behind the writer. None of them can be killed.
> 
> [...]

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

[1/5] fs: make syncfs(2) killable on s_umount
      https://git.kernel.org/vfs/vfs/c/da3b792b402a
[2/5] quota: make quotactl_fd(2) killable on s_umount
      https://git.kernel.org/vfs/vfs/c/e0f5107f9bad
[3/5] fs: make mount(2) remounts killable on s_umount
      https://git.kernel.org/vfs/vfs/c/6e6bd71c9d73
[4/5] fs: make FSCONFIG_CMD_RECONFIGURE killable on s_umount
      https://git.kernel.org/vfs/vfs/c/6bde4be1844a
[5/5] fs: make umount(2) of the root killable on s_umount
      https://git.kernel.org/vfs/vfs/c/8a869af72cff


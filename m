Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207347;
	b=ILChicGNk59ztsozkcnH9SQsVovnSlkEE+01DzDERrWYMPIVfDqCDZZ0fDfCTrJNHPeW
	 v/PaXbuHtxpg5jj/OmjYh7bcNvUd/cW6mLSkE3RKNwpNxGBXp081iHAsuQLY9XrcO5v8X
	 4KavYLXRmuZ9ZcyIbNn3Vw5DCPTiJs1I8GLtr2vWyNdSsQR6cW320HjRX2qwlQDYjn6dQ
	 VEhjoWBIo1+Puj44MxRu0SrosXhI40oKmPacJomFD9jSYTgJ7eEkHnExujxFHptOoHJ8s
	 KALPMbggxiJbcKi1CE36fehHa6D/O/7O1qvFlCEflav6pyrx3bF5CgSwZ7bwKo+CgOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207347;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=JY1vZIgRiM5NsJl1wPNeOXCDiP+um8a3m9EeDgiFiVk=;
	b=pP488opwcssJTSCcR4jcP7xQT12JT47g92UDzOMw9xc7Z2/pPr0jSW0FDybCDopUwkV+
	 PiI3rz9sRCMVV+eacH4kEtwHApsNtNeAK7ktqp4bCd7yWXR96abdFRsDStqow7kkHvYTC
	 H7K1Q82RlFS4DLjKwZII38hoNacUoqbFzFvYhbw/fA9Rb0iOieJ/usemMypZyD+sMLvw/
	 EmQGmRQd6TVoriSasE13i6KzQeuVpvNMuQfRD8GR/u2DBkLXcSfJJmhWAR2FXEIxRTDz4
	 +jxg+JkgJx0lqSCSg2BGs8+EI9r518LEQHvIvcwdNOcNpJzVEVH/iG0sn78SuaNElzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miAF077r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31434606A6C0;
	Fri, 20 Nov 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miAF077r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB071F000D4;
	Fri, 20 Nov 2026 20:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207346;
	bh=JY1vZIgRiM5NsJl1wPNeOXCDiP+um8a3m9EeDgiFiVk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=miAF077rNHBJFZ94WMh0jZKYrv63/zQCEj0mvtqPPDsVAO/btg7Z+us2vw9xaRlcC
	 uFc+yGUdKIWIqV4RRQ+qk8z/YySG03TZNGuPNO7kGgjFXbCq8AKwoQa3p+RVJrbUYV
	 f5nPwESmQ+f8KznDodGIie3Ag+PIvnTqoYzcpk5oA6i0PQBcV8XkBGe1S0PAuloe0Q
	 qVXL4w/PEaR4r3/DssUW++y+HidB/ZkV+sV/RwSiht9mFEhrBC7pXnZLcEhCBrjGxN
	 js5m2UwjP63W+m6uPX0P8N5QmMiOIzDud95rdAowgTMFJj/P4WwiXiYjpu7YPF/HYH
	 bto4uHiWsyzFQ==
From: Christian Brauner <brauner@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 Ian Kent <raven@themaw.net>, "T . J . Mercier" <tjmercier@google.com>, 
 Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261118220154.2965621-1-shakeel.butt@linux.dev>
References: <20261118220154.2965621-1-shakeel.butt@linux.dev>
Subject: Re: [PATCH 0/6] kernfs: stop taking kernfs_iattr_rwsem for writing
 in mkdir/rmdir
Message-Id: <20261120-taverne-tonband-bunker-6b0699c075d4@brauner>
Date: Fri, 20 Nov 2026 21:42:22 +0100
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

On Wed, 18 Nov 2026 14:01:47 -0800, Shakeel Butt wrote:
> In the Meta fleet, cgroup mkdir and rmdir can stall cgroup operations
> on the whole host.  They hold cgroup_mutex and kernfs_rwsem while they
> wait for kernfs_iattr_rwsem, which every path walk takes for reading,
> and they take it once or twice for every file of the cgroup.  systemd,
> clone3() into a cgroup, BPF queries and the OOM daemon all wait behind
> them.
> 
> [...]

Applied to the vfs-7.5.kernfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.kernfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.kernfs

[1/6] kernfs: report times and link count from the node in getattr
      https://git.kernel.org/vfs/vfs/c/793fdbff8747
[2/6] kernfs: don't copy times and link count into the inode on refresh
      https://git.kernel.org/vfs/vfs/c/98d1b8f98844
[3/6] kernfs: don't take kernfs_iattr_rwsem for the directory counters
      https://git.kernel.org/vfs/vfs/c/77e95f59b821
[4/6] kernfs: don't take kernfs_iattr_rwsem to publish KERNFS_REMOVING
      https://git.kernel.org/vfs/vfs/c/ead252b9937f
[5/6] kernfs: update a directory's times without kernfs_iattr_rwsem
      https://git.kernel.org/vfs/vfs/c/992996523359
[6/6] kernfs: don't take kernfs_iattr_rwsem in __kernfs_remove()
      https://git.kernel.org/vfs/vfs/c/af421cafc6ce


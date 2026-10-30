Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372071;
	b=qArdmn7aR4E7Yi4TmxDh6NJheQQ1ab+JxWoTPe9+C77yQTq/VCUMwn5+gTV9wmqrtsBy
	 cE1MEdoNAeBVR+N0QL3iVXQQXXtELm8RxRPBMURiwAyV8zMoSOKKoEprh+7VZ77n0lwhZ
	 6BtHk0VOT4AZZbk6jO+z+cjZBP68TzN88Ks4J/qikuP885ioEBb8bgZv7LtF6mlBCylwk
	 2De7O4LEYFz9KF2FCEEGy9AqhFNYBBdJdFCZF5AJLZGyRfZFoA+L+hpXhZLF0Fuy3EyXu
	 DgIzN/HjayUJ6kcQfF1L9vssW3Iq2oHJg6P1XlcgjFGu83Y+Y44XYbX7tF5K2JvfxQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372071;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=3s1rxc73Pszy84w3pPfs3G0d/mIrSkqd+Qg7Dv+AAj0=;
	b=AhbEVNV4o+rrh3IlkkhL94FMsifWiWdYQMMk+W4DNfyMqlbBvmZQ7MamSS5X6gmxJ8sw
	 hg2L3rtmDj3nu1sQOhNTdodF0tpDSF5B9uLn0eZh7gfQBmbQ83PuzoP36F4r68viX2A1Q
	 upO4J6UMaGsiNnJMytjKd18tCjh7b1FrSDFQo42myxBlSgKGOr1HfwcVq7ANyFdTinLOB
	 tu1giFfwQSTPZzuLliYpP2yQLFhXaKmoLS1Cj46DBzb0OVNLbGdsbYsuloaM0ha+8clE7
	 /oJ7zhyMfnYEeqaB3tqiLZ247Q+XRZRZNTrzCn0JeoXzV2qq3xZvzc4eA0jXtWzLL9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DV+zgiw/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B3606A32F;
	Fri, 30 Oct 2026 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DV+zgiw/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD6A1F000C1;
	Fri, 30 Oct 2026 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793372071;
	bh=3s1rxc73Pszy84w3pPfs3G0d/mIrSkqd+Qg7Dv+AAj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DV+zgiw/wvqeTdw340K4EG/fFhVeHzikYj1maVObe7yr2RLYKZuaCLFa8Sd/++rpR
	 lpW6l3nmfHusjvne5xsqCUpBlX4kbMQo8B9cjgs5zCsoDnzUSPUuLEuypY7mqNdwph
	 QUtIBXAfgQTvWW1L1gf2xW+E+AXGtrNWAGMIJr32E9auczDR4dWe+zT9MPFfxIQ/lT
	 FLuaGHh86s333lKYoyt2HFHa4a1ovjB+27rRQAknjZkMDiwj+TFJMKu5KCgoCIMsWN
	 0tt0kdtW32b7yn6Gj5neRpkXMwtGsFgWNGNJr6ptSGaeAZnKAqQJhif33s9A2P7ZfI
	 76ZNi8W6CDoxA==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: jack@suse.cz, jlayton@kernel.org, cel@kernel.org, neil@brown.name, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261023111250.17696-1-zhaogongyi@bytedance.com>
References: <20261023111250.17696-1-zhaogongyi@bytedance.com>
Subject: Re: [PATCH v2] filelock: keep superblock active through delegation
 wait
Message-Id: <20261030-dorfbewohner-klarzukommen-eindimensional-5fad175f1b69@brauner>
Date: Fri, 30 Oct 2026 15:54:27 +0100
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

On Fri, 23 Oct 2026 19:12:50 +0800, Zhao Gongyi wrote:
> A caller may drop its path after try_break_deleg() returns a delegated
> inode but before break_deleg_wait() finishes. The extra inode reference
> held in struct delegated_inode does not keep the superblock active.
> 
> After a lazy unmount, closing the delegation holder can release the last
> mount reference and shut down the superblock while another task waits for
> the delegation break. The waiter's final iput() can then enter the
> filesystem's eviction code after its superblock-private state was freed.
> This has been observed as a KASAN use-after-free in shmem_evict_inode().
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

[1/1] filelock: keep superblock active through delegation wait
      https://git.kernel.org/vfs/vfs/c/c206cdfee6c0


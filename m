Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A23C09E4;
	Thu, 30 Jul 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408750; cv=none; b=izfbiki/D9ui099wz9WsdXL4dzgRUYyufFLGM+KsZpZSrm4wsqURv6YWIG5RZ0uLxnShlb6fOwSS8A2LXT1Vioeu0efSjJbahq6/JTeQO4JU7lUJS7lsrZSbrPf0BDAHca3KRsPipvVhGzilRDSup2v/qEw0SeIVW7WHYBIudZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408750; c=relaxed/simple;
	bh=UvKCq7l6psv+9VQB3BKj5A3SAuB5ZkDp48bUDA8pE4k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=FSuo4/mSCej8epnvUyXoVUiIRXiWDamGAN8TA8o6x5Bk3fskqqYsD5vJ4/R9791ZPsA5p2QW1CUEBN0yxhYMc8Sqj+O8BAC9e1VZAvSv5NiI3dJbpg00/mNpUVVOhJHkLpi0zZJxTSWDWJWU3aeJcmbYuNrZg6bF3jNWVvjKQyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaNLiHQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaNLiHQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607E31F000E9;
	Thu, 30 Jul 2026 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785408748;
	bh=6nnfs8nNtVlnONzrxIfe8gTsLCSK014Od3NMgnHpEGA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=TaNLiHQ5r12KveIkqUueqgJ6znUisBjF6CuJz+NMS6O197mlNPse6/Ni1Ei/ySsQm
	 Yz4ZsvWiEGISLo/wxSBykWjwf9jZoalchbdbGC2X7rcDOI5HYlYB3r7ylfSezU/+bf
	 A2i+DbRpHPg8V5CqM/QqWCRCuMO9r4R2q+bfs5u1Yokofjic+3rTfSQHq5ZyN0/X7M
	 hX32l1x5bSDcstnwqCcPBTEqmZr1gVjirnqoW8Q/WoPoidK9UBfszrTRhnG6DgFpfR
	 BKCfuDNzZ1qNliYLQKGUNHSRX5HN1F4PnjiIuJOJydW69E7gWhrhYzc/JkKI4LjdHB
	 20a6NCZn3WLjA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 0/2] init: boot image-based systems without an
 initramfs (rootimage=)
From: Christian Brauner <brauner@kernel.org>
To: Eric Curtin <ericcurtin17@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 fsverity@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260727103104.2531937-1-ericcurtin17@gmail.com>
References: <20260718191551.1703670-1-ericcurtin17@gmail.com>
 <20260727-gepaukt-eislauf-waran-7c03f0e47609@brauner>
 <20260727103104.2531937-1-ericcurtin17@gmail.com>
Date: Thu, 30 Jul 2026 12:52:23 +0200
Message-Id: <20260730-bemalen-beigaben-distribuieren-89fb44589e20@brauner>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4029; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UvKCq7l6psv+9VQB3BKj5A3SAuB5ZkDp48bUDA8pE4k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRl67x8NtvI4Eps49UF62r3xu6yUzb49jtmRvW6xB3rX
 OwY1k+511HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRqSaMDHsmVs9dJV24Ntdp
 28I5Pk/Wzv6/dtNdPtsDk89abT6xpPs1I8O3qH8nXcxjPwfd3RYf13o2pSBF+mOlHv/JntBHmY3
 f1nMBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-27 11:31 +0100, Eric Curtin wrote:
> On 2026-07-27 10:55 +0200, Christian Brauner wrote:
> > So I have several structual and design issues with this.
> [...]
> > You're embedding a whole deployment topology into the core code here as
> > well... There are _five_ interacting __setup parameters. Every real
> > deployment immediately wants a sixth knob: A/B fallback inside the
> > mechanism. Because in your current model every failure is a panic().
> >
> > But that also means image selection must live in the bootloader anyway:
> > composefs/overlay stacking, LUKS-encrypted state partitions as command
> > lines can't do crypto secrets, fsck of the carrier, directory-based
> > deployments yadayadayada.
> >
> > This is just turning do_mounts.c into policy it shouldn't be involved
> > in.
> 
> Thanks for the detailed review. Let me state the goal plainly, since I

This kinda reads like a complete 1:1 dump of an LLM session...

> think it explains the choices even though several of your specific
> findings below are real bugs I should just fix rather than defend.
> 
> The goal is A/B image updates from a *single* partition, without
> paying for a second userspace spin-up at boot.
> 
> Today there are basically two ways to do A/B on Linux:
> 
>  1. N partitions/dm-verity volumes, each a full root image, selected
>     by the bootloader (dm-mod.create= + a GPT attribute flip). This
>     is the ChromeOS/Android model. It costs Nx the storage/partition
>     budget up front and the slot count is fixed at provisioning time.
> 
>  2. A single filesystem holding N image files (what bootc/ostree/
>     composefs already do), where something picks which file becomes
>     root. Far more space- and slot-count-flexible, but "pick a file
>     and expose it as root" is currently dracut/initramfs's job, so
>     you pay for a whole extra userspace stage whose only work is the
>     five steps in the cover letter.
> 
> rootimage= targets (2): keep single-partition flexibility, drop the
> "spin up a second userspace just to switch_root" cost. On fast-boot
> targets that first userspace (loading dracut/busybox, forking,
> possibly loading modules) isn't free and is pure overhead for five
> mechanical steps.
> 
> To be clear, I'm not trying to relitigate "no bootloader spec in the
> kernel" - I agree with that call, and A/B slot selection/fallback
> bookkeeping is meant to stay in the bootloader, exactly as it does
> with dm-mod.create= today. rootimage= is only meant to do the same
> mechanical "resolve the one path the bootloader already chose, verify
> it, make it root" step dm-mod.create() does for partitions - just for
> the file-backed case, where there's no dm table to describe it. So
> the "sixth knob" is intentionally out of scope; where you're right is
> that I haven't specified what happens when this step fails (currently
> panic()), and that needs a real answer, not "bootloader's problem".
> 
> On the rest, these read like real bugs, not disagreements, and I'd
> rather fix them than defend the current code:
> 
>  - filp_open()/fput() unused, and no guaranteed relationship between
>    the fsverity-checked file and the path/inode init_mount() and
>    erofs's own filp_open(fc->source) resolve independently - agreed,
>    this needs a real "mount from an already-open fd" path.
>  - multi-device erofs / rootimageflags=device= meaning the digest
>    only covers the primary image - agreed, real gap.


>  - the carrier fs being fully parsed, including reading the fsverity
>    descriptor itself, before anything is verified - agreed, that
>    ordering defeats the point.

Yeah, and it's unaddressed as are all the other structurual issues.

>  - zombie superblock / dangling source path / no loop-style
>    backing-file equivalent after detach - agreed, needs fixing.
> 
> I'll rework this into a v2 that only tries to solve the "take an

Why? The structural issues are all still there.


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D23988FA;
	Mon, 27 Jul 2026 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142509; cv=none; b=N7+fV3pbZJlTqYXPukd4t5i9+9wvNSCKnU7E/riAwUvc3JAo3nE7v+kEZV2WgiX7Hed9pJC7RbU++vyNdadLXdmLao0YWYMyfs1CtzX0Qe2yXN6e0OFjlfClwlo3L3vUM+lAX2uoqts5F4wrqm/e6JNtrOkHOM/YdGTl9XiMhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142509; c=relaxed/simple;
	bh=VIUIcef0y8xYwHIZfq8XT5DSP1PTByonZZgZX4jYJjc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QHDDmxKV6kk/osm0Fnhz2cmdZZFDsfMwfSJRj1Ts+92kGmVxOWcJ0rYcVjl3HNFo24f62gu+XSWNXJ/J8YEysSNTchdBrJB6VavcfkSValYSmpuwRDgPoQ4vmr61EqSAfRbDPPJ6PC6m3bTCAOkDahoXmW5KTRN/NSW8WlC9tmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsgd1Pbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsgd1Pbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C3C1F000E9;
	Mon, 27 Jul 2026 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785142508;
	bh=wmpAzoIh2ygP1QxiJ0z6lzAFz+KkFkXT++K3Z7V9lFI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=nsgd1Pbvsa+4SSMZehnETFGVhpGyLEzoKmBhd2uDuIV1WlMnjyi4qkFqsSGs66BLO
	 dIM9Nuvp9lUuuDS6BmeMMLAnjqfnvPu6fHYRKpHz7gdYfBEaA+wB5fPGCRnm16aV9Y
	 FlRfQt3zgWlxlX3sLYQRYXEOBCZwouSI4M8AmdXSg7OWGFShYInus70UUVgor6ndg/
	 M+b2EG/dBoiFO2NWZVgDPQKat3AcGYTrXgGJ5AYMgHs2siflaNyQc9oh95rVkbGJlU
	 liigB0DprAss5cAExm4Y8E4Fp6KvT+NtK463P3GnS6SehKUJiZOnYiVveigtNynuHv
	 bSbJI+vT1SCWQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH 0/2] init: boot image-based systems without an
 initramfs (rootimage=)
From: Christian Brauner <brauner@kernel.org>
To: Eric Curtin <ericcurtin17@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 fsverity@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260718191551.1703670-1-ericcurtin17@gmail.com>
References: <20260718191551.1703670-1-ericcurtin17@gmail.com>
Date: Mon, 27 Jul 2026 10:55:02 +0200
Message-Id: <20260727-gepaukt-eislauf-waran-7c03f0e47609@brauner>
X-Mailer: b4 0.16-dev-09492
X-Developer-Signature: v=1; a=openpgp-sha256; l=6395; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VIUIcef0y8xYwHIZfq8XT5DSP1PTByonZZgZX4jYJjc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSly7zw7ZB7Kf+6ecWdBS1c69VMY7dZr7gS7rOJ5bN7W
 9TlXzYCHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5E8TIMDtn5qttv9rf8K2f
 tPnglW+CZzptLWcUPj1/6dbTQwJ7vGQZ/qmw1DswbnJ9uPXr1/kZ7ifDTOy/lPbdiNp9unKXvN9
 JezYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-18 20:15 +0100, Eric Curtin wrote:
> Image-based Linux systems (bootc-style OS updaters, ChromeOS/Android-like
> A/B schemes, embedded appliances) keep one or more immutable root
> filesystem images as sealed files on a writable filesystem and pick one
> at boot.  Booting such a system today always requires an initramfs, even
> when that initramfs has nothing else to do; its only jobs are to parse
> the kernel command line, mount the state filesystem, verify the image,
> loop-mount it and switch_root into it.
> 
> This series teaches the kernel to do all of that directly:
> 
>   root=PARTUUID=... rootimage=/deploy/a/root.erofs rootimagefstype=erofs \
>       rootimageverity=sha256:a9548f4c... rootimagesrcdir=/var/state
> 
> Patch 1 adds rootimage= (plus rootimagefstype=/rootimageflags=/
> rootimagesrcdir=): root= then merely names the "carrier" filesystem.
> The image file on it is mounted read-only through the filesystem's
> file-backed mount support (available in erofs since v6.12), so no loop
> device is involved, and it becomes the root that prepare_namespace()
> pivots into.  The carrier mount is detached by default, or moved to
> rootimagesrcdir= inside the new root, which image-based systems
> practically always want since the carrier holds their writable state.
> 
> Patch 2 adds rootimageverity=, which requires the image to carry a
> specific fsverity file digest, reusing the fsverity_get_digest()
> interface that IMA and overlayfs already use for digest pinning.  With
> a signed or measured command line (e.g. a unified kernel image), the
> chain of trust extends to every byte of the root filesystem with no
> userspace boot stage: the pinned digest authenticates the image's
> Merkle tree root, and fsverity keeps verifying reads against it at
> runtime, so later tampering with the carrier is caught as well.
> 
> This is the file-backed analogue of dm-mod.create= (CONFIG_DM_INIT),
> which moved the equivalent block-device setup out of the initramfs for
> verity-partition layouts back in v5.1.  For file-based deployment
> layouts nothing similar exists, so distributions ship a dracut stack
> whose only purpose is the five steps above, and which remains the
> largest and most failure-prone moving part of an otherwise fully
> image-defined boot.

So I have several structual and design issues with this.

In the first pach the filp_open() and subsequent fput() are unused.
And that claim "the image cannot change between this open and the mount
below" is resting on very weak assumptions.

The second patch then checks the digest on the struct file from its own
filp_open(). But the mount goes through init_mount() with the path... so
erofs does a third lookup via filp_open(fc->source)...

Nothing guarantees that there's a relationship between the verified
inode and the path the superblock is created from. The only guarantee is
that no userspace yet exists but which can't really be enforced.

To support this properly we need new infrastructure such that you can
actually hand an already opened file as the source. I know that erofs is
intended to merge support for this at least but this should be generic
infra available to any fs.

Note also that the default detach mode creates a zombie superblock and
the image superblocks source string (/root/deploy/...) dangles after the
pivot. /proc/self/mounts names a path that doesn't exist in the final
namespace. And unlike loop there's no /sys/block/loopX/loop/backing_file
to recover which file backs the root.

The other claim is that the digest sufficiently guarantees the integrity
of the root filesystem. That's not correct per se...

An erofs multi-device filesystem blows this apart and
rootimageflags=device= would also add more. So that digest only cover
the primary image.

The bigger flaw is that the untrusted "carrier" (LLMs do pick the worst
terms for things...) is fully parsed before anything is verified.

In other words, mounting the carrier means running the ext4 (or
whatever) parsers and infra over attacker-writable data, and the
fsverity descriptor are themselves read from that untrusted fs. So
basically you're hosed before you ever got to the fsverity part.

This is also now the third fsverity-digest-pinning mechanism (IMA
appraisal, the IPE LSM and now rootimageverity=). With the least
expressive policy language of the three. No signature or keyring option
either and so the boot entry must be regenerated per image update.

You're embedding a whole deployment topology into the core code here as
well... There are _five_ interacting __setup parameters. Every real
deployment immediately wants a sixth knob: A/B fallback inside the
mechanism. Because in your current model every failure is a panic().

But that also means image selection must live in the bootloader anyway:
composefs/overlay stacking, LUKS-encrypted state partitions as command
lines can't do crypto secrets, fsck of the carrier, directory-based
deployments yadayadayada.

This is just turning do_mounts.c into policy it shouldn't be involved
in. We just refused pushing the bootloader spec into the initramfs for
the same reasons - and that one I'm much more sympathetic to since I was
involved in creating it. I'd love to see parts of that in the kernel but
I refuse it because I believe fundamentally the kernel is in the
business of keeping complexity in userspace not the other way around.

Also the users the cover letter touches on such as distro kernels ship
erofs and its decompressors, the block drivers, and the fs stack as
modules. Afaict, rootimage= needs all of it builtin:

- bootc/ostree: composefs — multi-mount + overlay + external objects.
  inexpressible here and partially unverifiable
- ChromeOS/Android-style A/B: dm-verity partitions already served by
  dm-mod.create= and a fallback story.
- embedded squashfs appliances: no file-backed mount support in squashfs

What remains are single-erofs-filesystems with fully-builtin kernels.
That's kinda what CONFIG_INITRAMFS_SOURCE embeds a five-line static
/init into the same signed/measured kernel image with identical trust
properties and full policy freedom.

UKI users likewise already sign and measure their initrd as part of the
PE. The series only really makes sense if you get rid of that.


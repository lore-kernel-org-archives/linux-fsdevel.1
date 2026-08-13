Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4738417BD2
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621891; cv=none; b=LZyg2qbM+cp+Azb8rkIxcG6pyrwRmjJs5nQqN/vrrbnCyVF9xAVfamL5445is2UTPoYI65wcUA0Jh+N5EBPr8nkqF6CQttextX3sM/WTnDOE5Vrg2JIB/98AZo+oAc2SwZUCS8dHvWG6Jrn01vQkBtoihWeP9i1Z6cYZsb9nss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621891; c=relaxed/simple;
	bh=3HkEaQiRlR1XZ3DDZ2fVYnvgbJ9qmUQXOloIeGQa7gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODL3qCEQFtzIIzREhSeijJyzWn2qgMEv/jKNlt07nOv1/IkrFL9MQ43Pp8aHKsCj6UrMnGQWgNPf7gT+lKr923UHkq8EEbU9LpbxNPIPUGl+m3+/Ys6gyW45LtYsdkug29KYRtc6eSaeBje8n9YBC+DYiNUYYka9OGWjyAKsQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMVToVk4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMVToVk4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DB81F000E9;
	Thu, 13 Aug 2026 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786621889;
	bh=JvESJkga9jdlK0rgNoYtj3HeOE+zzwc0hSXdxTbTp0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AMVToVk4MFkR7P4cmxVK1KGPrT2kUbr3NX9zQalw94nz2PqbcTBReXKNgk2gPLsls
	 yVRUWAgPSrtw9Ny4VIrXWNYwwikUi1PSeuxw6ClzbfPM9EjafJDrXsvyCuYz2kkjFI
	 fryOK4XINON/elk09G74hV1TT4vCHNJ0sQ7haD4fGAYOj/G1KvzNe+guhG1UdrZiNI
	 Pz5arx2wk6jwUCNynDjul98OPA3aUofKMzaTUHV0q8+YbZ25o9xQ/T6KEJbkFVRewz
	 lECyQv/dVyADzouIgs/HyQ1rceLrMkwvof/n4lksAEx4ceeaL3crbYfHN/xp/n2+XB
	 N0QtPpredee0Q==
Date: Thu, 13 Aug 2026 19:51:21 +0800
From: Gao Xiang <xiang@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
Subject: Re: [PATCH v6 2/2] erofs: reuse superblock for file-backed mounts
Message-ID: <an2vuT1Va8JjdLug@XiangdeMacBook-Pro.local>
Mail-Followup-To: Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
References: <20260812142907.1010046-1-gscrivan@redhat.com>
 <20260812142907.1010046-3-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812142907.1010046-3-gscrivan@redhat.com>

On Wed, Aug 12, 2026 at 04:28:04PM +0200, Giuseppe Scrivano wrote:
> When the same file-backed image is mounted multiple times (via path or
> fd) with the superblock_share mount option, reuse the existing
> superblock instead of creating a new one.  This allows multiple mounts
> of the same image to share in-kernel data structures more efficiently.
> 
> The backing file is identified by its inode and fsoffset.  If mount
> options conflict or extra devices are used, a separate superblock
> is created transparently as a fallback.  Remount is not allowed on
> shared superblocks.
> 
> Tested by mounting a 177M Fedora EROFS image 20 times with full
> traversal:
> 
>   #!/bin/sh
>   IMG=${1:-/root/fedora.erofs}
>   OPTS=${2:+-o $2}
>   N=20
>   DIR=$(mktemp -d)
>   trap "umount $DIR/m* 2>/dev/null; rm -rf $DIR" EXIT
> 
>   sync; echo 3 > /proc/sys/vm/drop_caches
>   INODES_BEFORE=$(grep erofs_inode /proc/slabinfo | awk '{print $2}')
>   MEM_BEFORE=$(grep ^Slab: /proc/meminfo | awk '{print $2}')
> 
>   for i in $(seq 1 $N); do
>       mkdir $DIR/m$i
>       mount -t erofs $OPTS "$IMG" $DIR/m$i
>       find $DIR/m$i > /dev/null
>   done
> 
>   echo "Superblocks: $(grep $DIR /proc/self/mountinfo | \
>       awk '{print $3}' | sort -u | wc -l)"
>   echo "erofs_inode delta: +$(( $(grep erofs_inode /proc/slabinfo | \
>       awk '{print $2}') - INODES_BEFORE ))"
>   echo "Slab delta: +$(( $(grep ^Slab: /proc/meminfo | \
>       awk '{print $2}') - MEM_BEFORE )) kB"
> 
> without superblock_share:
> 
>   # time ./test.sh /root/fedora.erofs
>   Superblocks: 20
>   erofs_inode delta: +45864
>   Slab delta: +37448 kB
>   real	0m2.311s
>   user	0m0.222s
>   sys	0m1.998s
> 
> with superblock_share:
> 
>   # time ./test.sh /root/fedora.erofs superblock_share
>   Superblocks: 1
>   erofs_inode delta: +2044
>   Slab delta: +284 kB
>   real	0m0.679s
>   user	0m0.157s
>   sys	0m0.469s
> 
> The time difference shows that sharing the superblock also benefits
> the page cache and inode cache, as subsequent mounts of the same image
> avoid re-reading the backing file.  This is particularly useful for
> container hosts running multiple containers from the same base image.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

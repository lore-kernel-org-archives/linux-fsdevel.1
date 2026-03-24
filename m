Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721483DB621
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342100; cv=none; b=au//ECdsg0hGTONGvU+XPstFKvhzkOUZquylElrS7l/yWVI6qch+e9WO0gEk+lg2MLhENZ7EEN9/kNXeeYD0Db1d6WJ62lgzdB+qthC/PsGi/h7vb6VAJEUG6jWDtTbLkYT+/nYU4mNgUBYEzGgMBoCnnFhqzaYmF7BboQWqFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342100; c=relaxed/simple;
	bh=C0HalSfam8hcqVvTVey8SiJiDSfAuC+XOQ+2O1EXF50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/Ge73csmNHf05WJoxFNuN8yCUQ+hokV/O7JUxrsnlVHGEpO9Iw6vXwvgb35DkJvas0EW91/+3OOxyzICN0C5ddNLbl26Hr4ZZX3QJuOJv/BaWEuccW42HzjIk9c1SY5tBSmtQZAVsrAQS9UJKhCbWgDc0bFxcBXlY7VkFaq8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un30CzWA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un30CzWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17F1C19424;
	Tue, 24 Mar 2026 08:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774342100;
	bh=C0HalSfam8hcqVvTVey8SiJiDSfAuC+XOQ+2O1EXF50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Un30CzWAxLpoCY0tkhvqkyZDgQXb5GPZFfd24YhC+G6I0CT+j0i25X79WE61JFOwU
	 576BfWB3iCIFDmh5xrH//jDhqxMJ5d86iI4vWrrXjoH21UdQtT8HLSgdqbxRevPTrl
	 L/OfNqQo4xN1hEcv0eqZ/PSLju5SiZKA4d/B6R2W1gejUQtVcSfasydvbvrQmf9gCI
	 tC6F7NK67cUjQvf3jJaWRapVT6Tj0txVvTGs6B3KjyAYf9NBI3I/I8E4w4zCCZislW
	 zobOAWbz0xUoGckbrPpLsqjbfYlNHy+nt3KwaZQfrEwTrEINKMc82Luy9BbkYHLc4x
	 wGCQ5FRrrYmUA==
Date: Tue, 24 Mar 2026 09:48:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>, 
	Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>, 
	Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>, 
	Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260324-hilfen-reibung-9783005d5d0f@brauner>
References: <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
 <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
 <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
 <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>

On Mon, Mar 23, 2026 at 03:47:24PM +0100, Jan Kara wrote:
> On Mon 23-03-26 22:36:46, Gao Xiang wrote:
> > On 2026/3/23 22:13, Jan Kara wrote:
> > > > > think that is the corner cases if you don't claim the
> > > > > limitation of FUSE approaches.
> > > > > 
> > > > > If none expects that, that is absolute be fine, as I said,
> > > > > it provides strong isolation and stability, but I really
> > > > > suspect this approach could be abused to mount totally
> > > > > untrusted remote filesystems (Actually as I said, some
> > > > > business of ours already did: fetching EXT4 filesystems
> > > > > with unknown status and mount without fscking, that is
> > > > > really disappointing.)
> > > 
> > > Yes, someone downloading untrusted ext4 image, mounting in read-write and
> > > using it for sensitive application, that falls to "insane" category for me
> > > :) We agree on that. And I agree that depending on the application using
> > > FUSE to access such filesystem needn't be safe enough and immutable fs +
> > > overlayfs writeable layer may provide better guarantees about fs behavior.
> > 
> > That is my overall goal, I just want to make it clear
> > the difference out of write isolation, but of course,
> > "secure" or not is relative, and according to the
> > system design.
> > 
> > If isolation and system stability are enough for
> > a system and can be called "secure", yes, they are
> > both the same in such aspects.
> > 
> > > I would still consider such design highly suspicious but without more
> > > detailed knowledge about the application I cannot say it's outright broken
> > > :).
> > 
> > What do you mean "such design"?  "Writable untrusted
> > remote EXT4 images mounting on the host"? Really, we have
> > such applications for containers for many years but I don't
> > want to name it here, but I'm totally exhaused by such
> > usage (since I explained many many times, and they even
> > never bother with LWN.net) and the internal team.
> 
> By "such design" I meant generally the concept that you fetch filesystem
> images (regardless whether ext4 or some other type) from untrusted source.
> Unless you do cryptographical verification of the data, you never know what
> kind of garbage your application is processing which is always invitation
> for nasty exploits and bugs...

If this is another 500 mail discussion about FS_USERNS_MOUNT on
block-backed filesystems then my verdict still stands that the only
condition under which I will let the VFS allow this if the underlying
device is signed and dm-verity protected. The kernel will continue to
refuse unprivileged policy in general and specifically based on quality
or implementation of the underlying filesystem driver.

Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFCD361965
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295681; cv=none; b=YgMcfNrKmSKiL9v12ieps/NhJ7z/Pyg7yW7Sbl96TGhUcZmZjJBeVzEfb2wqHmFKtQ49vBlhQzbPQFYmfoWAj5tbMl7U4ZgbRhVVZJrbXobGOffsAufG7OC0dKCjJxjumPu9OUX8QZn0Iq/Hio7mQCvWTxiB8SU9ZKCxZR48u58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295681; c=relaxed/simple;
	bh=SW5MrEctvBr/ciy2VGeAFp3fhna/qIyeCnNfBRDKrj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOYn7Aqsc+dqwg2OchjCvUZ0R0N3HI2uEj4qv0qhg33FOwn2IoKGxKjUGIq17PBBsHjiuIz/wTP2sSNgiPIJSQvcPHwxA1Q9dkIInipv+GLJeUpoZPeXbCmUmwXSJ6II0hJPEq4uuLrglqWg8qPzgrzQLjee/blmmXd0RWqMvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bcf2wGh7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bcf2wGh7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K49gEPJkO/WnFIaYmlco+0ys+WolIl9XCUB/3Yj+dKI=; b=bcf2wGh7+pM8bKwQRj3gFaMMO6
	tQ0qeY+8G/tlRpnP5RMMeOQEo2IIiAltWYk8u6rf5NYevD9KZIycHeN64cxQ/pGIo+4H3gfX/TuR7
	et5fS8yNbw1vceuMxe/K0NdEsdhaEAFGODfSshP1drPSwCp+Wz5xKsQJik+RN/ZzpAFrcXUt5ejEu
	9y6VHTBMPaSbjGh+HEY6OPfPCIgR79XzKumjQEMXS5YgZbQwD42V2SqC0cyFyUpcJeFy9spebzzbs
	jW+ANNR25Et06PhWcrbjsqqp3dteaIWaZommaVzxAfuagiyygMU8fd8lc4WTnELmHJFdmhW8EGq1G
	30hID4ow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIHyl-000000045US-2biC;
	Sun, 18 Oct 2026 03:54:35 +0000
Date: Sun, 18 Oct 2026 04:54:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/3] namespace: rework connected mounts
Message-ID: <20261018035435.GD3535232@ZenIV>
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
 <20261002-work-mount-cover-v1-2-232a8f52b43c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-work-mount-cover-v1-2-232a8f52b43c@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 02, 2026 at 04:14:28PM +0200, Christian Brauner wrote:
 
> @@ -1386,13 +1444,10 @@ static void noinline mntput_no_expire_slowpath(struct mount *mnt)
>  	if (unlikely(!list_empty(&mnt->mnt_expire)))
>  		list_del(&mnt->mnt_expire);
>  
> -	if (unlikely(!list_empty(&mnt->mnt_mounts))) {
> -		struct mount *p, *tmp;
> -		list_for_each_entry_safe(p, tmp, &mnt->mnt_mounts,  mnt_child) {
> -			__umount_mnt(p, &list);

BTW, at that point we are left with only one caller of __umount_mnt(), always
with &ex_mountpoints as the second argument.

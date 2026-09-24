Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32B318ED2
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224107; cv=none; b=PyIRZ81bAzSiKsweM0uAfHaeYFp9MFbex+dkOHWseWrOtCuZsyDW7p5mkVp/yMFb+CQRaoYRsaxYbcbd7nzDKAp2s1G4bDiDZAjL4Aenm+GYXgIZnCZzOFND1YbcuFcSV9vDSglLJ8ii9PSdNvv1LsbH0EmaVmcjozptoQOvmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224107; c=relaxed/simple;
	bh=EiBzhXFsUYn0dL5ALmLuRNVhxtT9Ru257kYUXxaMaCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIWaUcaSBGW736KdXOJ2uGl6ZFozadK2VhlYIeLQyxZ8TCao/TJC7TOrNyLdSLKxtiECxKKkpxg1fagKyiwku9kcWmKWQTyh1ozycvb7TR7oD/Iips6STyGHXRkaRLSo1tDQyTe8dKWMWGZgkQ9H3FgazKpgdFpuwUdFpytxwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsKOx0LP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsKOx0LP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD291F000FF;
	Thu, 24 Sep 2026 04:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790224106;
	bh=AMdxEOW2X4XJBSZCaDEFc4BpLNjP8026Li2ryRQqEck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SsKOx0LPUddnTdITTUfC64RXC2qfeA9NbyjUFDcQQrY9JvDdrvvSC7gySwBRoyovx
	 GwWroStO9/d6dDCdJHZ/ZGYOUXVcpi53BMCdXZtwPu0JHppiglBWLWy2FsjMGVWce0
	 7b2wmLylMEfThntuhQXH+axgdFxQGBiMaxLhmRlKCEpzaZ9YBG5232qIjhTOuKr9oh
	 lDlbTBsxrRGIcZ6pFUAtG8pJeBDhjdMgbT4+EVxx7T87ZdmOwo/c+o5TPAGDIdZOTX
	 /w/NXsq0wRFDye9JAjIzpk6HIcTCqLl8C7ZNXtL64UhuhAKKmZPzkdCQfZ+Tpe0LvZ
	 08PRMnGUi97xw==
Date: Thu, 24 Sep 2026 06:28:20 +0200
From: Gao Xiang <xiang@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Gao Xiang <xiang@kernel.org>, Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 1/2] fs: rename vfs_get_super() to get_tree_super()
 and export it
Message-ID: <arSm5OXgLD0xkTsv@MacBookPro.fritz.box>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
References: <20260811071241.389589-1-gscrivan@redhat.com>
 <20260811071241.389589-2-gscrivan@redhat.com>
 <antDVPzz0tbn2kTU@XiangdeMacBook-Pro.local>
 <20260825-gorilla-zuhilfenahme-unfug-4b81185496a3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825-gorilla-zuhilfenahme-unfug-4b81185496a3@brauner>

Hi Christian,

On Tue, Aug 25, 2026 at 02:32:48PM +0200, Christian Brauner wrote:
> On Tue, Aug 11, 2026 at 11:44:20PM +0800, Gao Xiang wrote:
> > (+ cc vfs maintainers)
> > 
> > Hi,
> > 
> > On Tue, Aug 11, 2026 at 09:10:50AM +0200, Giuseppe Scrivano wrote:
> > > vfs_get_super() already implements the common get_tree pattern of
> > > looking up an existing superblock via a test callback and initialising
> > > a new one with fill_super otherwise, but it is private to fs/super.c
> > > and only reachable through the get_tree_nodev()/get_tree_single()/
> > > get_tree_keyed() wrappers, none of which let a filesystem supply its
> > > own test callback.
> > > 
> > > Rename it to get_tree_super() and export it so filesystems that need a
> > > custom superblock matching policy can reuse it directly instead of
> > > open-coding sget_fc() + fill_super().  No functional change.
> > > 
> > > This is a preparatory fix for the next patch.
> > > 
> > > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> > 
> > With the new vfs_get_super() helper, it seems much cleaner compared
> > to the previous versions.
> 
> I'll add this patch to the vfs-7.3.super tree post -rc1 and then you can
> pull it in. Thanks!

friendly ping.. since I'm working on 7.4 cycle too, could you add the
latest v6 series to vfs-7.4.super so I could pull it in too?
https://lore.kernel.org/r/20260812142907.1010046-1-gscrivan@redhat.com

Thanks,
Gao Xiang

> 

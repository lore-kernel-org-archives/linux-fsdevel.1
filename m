Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D633CEA9
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589047; cv=none; b=WQfuWusqTTa+gzTbCO/Hhc7vQvJNtnQMfzi91KiyEL65RupSR2HDeIZn4hOHgwltuEOgz2L/chPF5H/sXuBjsWLbNE0S6iZb1B1/UNW0aCwTYcXU1kZoUL4LBKnOe6TfAQtNDRDvnoNtwDl6myCU1CVZMKpSIdBlGdpAP+R3cZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589047; c=relaxed/simple;
	bh=XKwJwNpWGK4YebK8QJHlzoXW+8DKfS5V1W0jHHhNEnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7KIa3mgJ5ksH+FIl/LTAvlpBykMC1c7YmApJTCHTDVwg+gmKISgJ8A6OTi3a7lLtgjIWTaNMV4XGIGp0zLmEpmQgNT66K271Jy9IX+fdW1UBHKHKiI2+x5lPqbiC9DeSnU5piSVl0+3NuOFAZ5/XCgnqF0QutT3ar9JNa6NnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdXRYfEE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdXRYfEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50250C116C6;
	Tue,  7 Apr 2026 19:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775589047;
	bh=XKwJwNpWGK4YebK8QJHlzoXW+8DKfS5V1W0jHHhNEnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdXRYfEEU0mP1Kqxi0cd3YXYAEdASTjm4Bn5a09xLBQw1QnQz3QWEC1lXQbYPuFKu
	 kgZoxoCKWD9CQEOA0OAFRZWrv4pGb63VITGdkCrPqDxJYg33im3mmv5SIhxIU5YhFK
	 OD3lDlSkpwgPUDzUYKgpT0/CufBoVAGq7m+5T7oFcRvpJWSGc5BeKw9H+gXjLDzU0j
	 r9ZJUiHIhtKeAriPA4XHdZctPHiYbQ+yFyYImU0gTQTmHPsRwALdCXtkt5YK15Ets+
	 9atPztkGAO2m7GZsNC51B2fWI0fnGgCXlpkRS/KATYI7pSPXkuOU6tWnsS21Og4HyX
	 V0D2bkNh8OSBw==
Date: Tue, 7 Apr 2026 12:10:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: fuse-devel list on kernel.org
Message-ID: <20260407191046.GL6254@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <adTyw4UJ04qOggCQ@amir-ThinkPad-T480>
 <c4ffec34-fad0-40d9-bff1-06c3cd202351@bsbernd.com>
 <CAOQ4uxhBC7eTkaB6Ws1DqewzxkGdEfcCyJ8EZszn+YeHwG0-wQ@mail.gmail.com>
 <5d7295b0-bd7e-41e7-b176-3d19b240413c@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d7295b0-bd7e-41e7-b176-3d19b240413c@bsbernd.com>

On Tue, Apr 07, 2026 at 08:05:36PM +0200, Bernd Schubert wrote:
> 
> 
> On 4/7/26 14:29, Amir Goldstein wrote:
> > On Tue, Apr 7, 2026 at 2:25 PM Bernd Schubert <bernd@bsbernd.com> wrote:
> >>
> >>
> >>
> >> On 4/7/26 14:04, Amir Goldstein wrote:
> >>> On Thu, Mar 26, 2026 at 10:34:33PM +0100, Bernd Schubert wrote:
> >>>> I'm taking Darricks example here and posting API changing libfuse
> >>>> changes to linux-fsdevel. We should consider to create a fuse
> >>>> specific list if that is too much. The existing
> >>>> fuse-devel@lists.sourceforge.net is rather hopeless due to lack
> >>>> of spam filtering.
> >>>>
> >>>
> >>> Let's do this already!
> >>>
> >>> https://korg.docs.kernel.org/lore-archives.html
> >>>
> >>> Do you want me to send the email to kernel.org?
> >>>
> >>> I suggest that we ask for fuse-deve@lists.linux.dev
> > 
> > Just don't copy paste my fuse-deve typo in the request ;)
> > 
> >>> and then we can migrated the old sourceforge archives
> >>
> >> I'm all for a new fuse mailing list.
> >>
> >>>
> >>> As far as I can understand getting the archives from sourceforge
> >>> required the admin password:
> >>>
> >>> https://sourceforge.net/p/forge/documentation/Mailing%20List%20Archives/
> >>>
> >>> Mikos,
> >>>
> >>> Will you be able to handle the archive migration?
> >>
> >> Have that password from Nikolaus.
> >>
> > 
> > Excellent, so will you be sending that email to helpdesk@kernel.org?
> 
> I can login here as admin:
> https://lists.sourceforge.net/lists/admin/fuse-devel with the admin
> password.
> 
> Here https://lists.sourceforge.net/mbox/fuse-devel which is supposed to
> create the mbox file it asks for "user" and password. Assuming the
> password is the same, what is the "user"? Also tried my user sourceforge
> credentials, does not work either.
> 
> Can we defer this a bit? Too many things to do and I think for now
> reviewing Joannes Patches and finishing sync-init and Darricks mail has
> a higher priority than fighting with sourceforge mbox.

I don't have a problem with deferring, but FYI you don't have to have
old ML history ready to go when you apply for a new list.  It, erm, took
us months to scrounge the entire xfs history together after linux-xfs
was created.

--D

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F23DA5A7
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647564; cv=none; b=fxyrwy69ur6tIfGr67/7Je2r6LUCFZKszs/GT2QLuiimQJzQ72l2ey2geBtBiej0q7Pq41wmywlPKMOUwyeaRobXAZ3XoarBIsnV+0OZcasP6Wn90KKQRWeMGwghmZ0Az8E9FB+mR++320KDw5AE18hd6LcR2VI6Yx+UMWpEe+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647564; c=relaxed/simple;
	bh=dki9+B7zUsPwANH8GWNR65HwjipagFWQR8hzkVM3jq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js27gbJqnmm3Rc64wPxnPMdT+zrnIaxMEJeZ9B6g4JQTv/wkNCGIiEI6OTrPRnASDFWgdXGJti+bakMXWQxV3atf2KojN4LGH4/eG8/dI6lch0nsKMIRzdNV/I57TlpwnMpw1dJa0lOuKgpWrGz1F8pFRRxFCBng2tSlEJe2NHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIlBFzS+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIlBFzS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2DBC19425;
	Wed,  4 Mar 2026 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772647563;
	bh=dki9+B7zUsPwANH8GWNR65HwjipagFWQR8hzkVM3jq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIlBFzS+vr6HZuWnfcopGTln2l17MGOWx4OhyKzvRI2AvktSERk1sTO7jOi+ApaQn
	 8D2hJCD5HYj5E/rPJYceI9yIpOJygOjM0qCPvMtqrG6NCVDuFHvPz0w+EWkAAlMCH+
	 hvD8Xft4U0A9D8Ug+T14MrLHtNrGW1LeORfNQ5RAdEQ7LaPlO4ppWmGX7JI3YROaDW
	 ZK/ulPgICY4KT9VTjzE/FyXUvZz3sVeGU7suuA7Sr9EoF4Hr3jceEwun8PS1KgoT+d
	 /rUrivSMoipHptF3kyBGeOMeAKR/yWjuCFJsHmHl3z3/FWjfVHmj92dr57qvxeGoWS
	 OwHTGt5In8kug==
Date: Wed, 4 Mar 2026 10:06:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
Message-ID: <20260304180602.GQ13829@frogsfrogsfrogs>
References: <177258294351.1167732.4543535509077707738.stg-ugh@frogsfrogsfrogs>
 <0d3d5dfc-6237-4d6d-abeb-e7adddecf2d9@bsbernd.com>
 <20260304170652.GP13829@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304170652.GP13829@frogsfrogsfrogs>

On Wed, Mar 04, 2026 at 09:06:52AM -0800, Darrick J. Wong wrote:
> On Wed, Mar 04, 2026 at 02:36:03PM +0100, Bernd Schubert wrote:
> > 
> > 
> > On 3/4/26 01:11, Darrick J. Wong wrote:
> > > Hi Bernd,
> > > 
> > > Please pull this branch with changes for libfuse.
> > > 
> > > As usual, I did a test-merge with the main upstream branch as of a few
> > > minutes ago, and didn't see any conflicts.  Please let me know if you
> > > encounter any problems.
> > 
> > Hi Darrick,
> > 
> > quite some problems actually ;)
> > 
> > https://github.com/libfuse/libfuse/pull/1444
> > 
> > Basically everything fails.  Build test with
> 
> Doh :(
> 
> > ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:24:10:
> > fatal error: 'systemd/sd-daemon.h' file not found
> >    24 | #include <systemd/sd-daemon.h>
> > 
> > 
> > Two issues here:
> > a) meson is not testing for sd-daemon.h?
> 
> Hrm.  meson.build *should* have this clause to detect systemd:
> 
> # Check for systemd support
> systemd_system_unit_dir = get_option('systemdsystemunitdir')
> if systemd_system_unit_dir == ''
>   systemd = dependency('systemd', required: false)
>   if systemd.found()
>      systemd_system_unit_dir = systemd.get_variable(pkgconfig: 'systemd_system_unit_dir')
>   endif
> endif
> 
> if systemd_system_unit_dir == ''
>   warning('could not determine systemdsystemunitdir, systemd stuff will not be installed')
> else
>   private_cfg.set_quoted('SYSTEMD_SYSTEM_UNIT_DIR', systemd_system_unit_dir)
>   private_cfg.set('HAVE_SYSTEMD', true)
> endif
> 
> # Check for libc SCM_RIGHTS support (aka Linux)
> code = '''
> #include <sys/socket.h>
> int main(void) {
>     int moo = SCM_RIGHTS;
>     return moo;
> }'''
> if cc.links(code, name: 'libc SCM_RIGHTS support')
>   private_cfg.set('HAVE_SCM_RIGHTS', true)
> endif
> 
> if private_cfg.get('HAVE_SCM_RIGHTS', false) and private_cfg.get('HAVE_SYSTEMD', false)
>   private_cfg.set('HAVE_SERVICEMOUNT', true)
> endif
> 
> 
> But apparently it built fuse_service.c anyway?  I'll have to look deeper
> into what github ci did, since the pkgconfig fil... oh crikey.
> 
> systemd-dev contains the systemd.pc file, so the systemd.get_variable
> call succeeds and returns a path, thereby enabling the build.  However,
> the header files are in libsystemd-dev, and neither package depends on
> the other.
> 
> So I clearly need to test for the presence of sd-daemon.h in that first
> clause that determines if HAVE_SYSTEMD gets set.
> 
> > a.1) If not available needs to disable that service? Because I don't
> > think BSD has support for systemd.
> 
> <nod>
> 
> > b) .github/workflow/*.yml files need to be adjusted to add in the new
> > dependency.
> 
> Oh, ok.  The 'apt install' lines should probably add in systemd-dev.
> 
> > Please also have a look at checkpatch (which is a plain linux copy) and
> > the spelling test failures.
> 
> Ok, will do.

...and the immediate problem that I run into is that all the logs are
hidden behind a login wall so I cannot read them. :(

(It leaked enough about the spelling errors that I can fix those, and
I can run checkpatch locally, but I don't know what else went wrong with
the bsd build or the abi check.)

--D

> --D
> 
> > 
> > 
> > Thanks,
> > Bernd
> > 
> > 
> 

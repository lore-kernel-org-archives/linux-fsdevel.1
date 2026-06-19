Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E53803E1;
	Fri, 19 Jun 2026 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873528; cv=none; b=EK//517sV/t0OtQA0A7kKoWgvRjvaX/sbmjubtEReOmmpzPbKAwpY//YswJHtmXz8UXGfbF1f9MRXKZVbSgrn2Db1g50V06VzWmPjDZ+sG4UyRpierkEgoPoGpiEq8aJ8naZd4jozVZSQktqJFv2QlPkKm8x9id+hWUBBJHzfPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873528; c=relaxed/simple;
	bh=vlt508OngfcR+AlEOvkl8S0fVWYMg2eEN/6ShAE1moI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBAMlwkMVQ31oL95dKCPKU5tcPEXdt1mxYrLV+MK1Z/CNwkLWJkKO0iL4ll18ahEN3SsQE8ST/g0QLM1sgKCpAHkgcczeS2NVTppprnnjkyKkG4aLbVVyyV336UbSH8P+B/GMfp/qgVOIY9EN8ueIXxdE4arH7F1la25cUfxuYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uhHiavHi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uhHiavHi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC8392936;
	Fri, 19 Jun 2026 05:51:54 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B22F83F62B;
	Fri, 19 Jun 2026 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781873519; bh=vlt508OngfcR+AlEOvkl8S0fVWYMg2eEN/6ShAE1moI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uhHiavHilkR8OcTBOY0TJKSGBxaoW08/UAVe/N1KNPtWhvkzKJ3SCBoM1/2SAFR0C
	 0oLzkmazgQ3yCc4ZqSRcH/ZceO+kPRQDgRPvK7UThLUBZssa4yyyDdNRxtsgUYjOD0
	 Pk3KPfkIqVDUSzfuWuVUbgGdAnDj83b4q7uQ8Uzs=
Date: Fri, 19 Jun 2026 13:51:43 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, sudeep.holla@kernel.org,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, d-gole@ti.com,
	jic23@kernel.org, elif.topuz@arm.com, lukasz.luba@arm.com,
	philip.radford@arm.com, souvik.chakravarty@arm.com,
	leitao@kernel.org, kas@kernel.org, puranjay@kernel.org,
	usama.arif@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v4 00/31] Introduce SCMI Telemetry FS support
Message-ID: <ajU7UqwPZBlwRGkf@pluto>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
 <20260617-waten-allabendlich-zueinander-93d4b1367b8c@brauner>
 <ajLVW1eHzbGDm4yn@pluto>
 <29a304f0-1e62-418a-b84f-aabdc4c0de8d@kernel.org>
 <ajR_FBWOoXJKSeoH@pluto>
 <0025b907-27b9-4a51-b78f-f8ad413644d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0025b907-27b9-4a51-b78f-f8ad413644d0@kernel.org>

On Fri, Jun 19, 2026 at 12:16:58PM +0200, David Hildenbrand (Arm) wrote:
> 
> >> Is the configuration aspect limited to enabling selected events, or is there
> >> more that can be configured?

Hi,

> >>
> > 
> > The needed configuration is:
> > 
> >  - global Telemetry enable (tlm_enable)
> >  - global common update_interval (current_update_interval)
> 
> Okay, so simple global properties.
> 
> >  - per-DE enable/disable (des/0x<NNNN>/enable)
> >  - per-DE timestamping enable/disable (des/0x<NNNN>/tstamp_enable)
> > 
> >  ... then there are a couple of handy catch-all entries:
> > 	all_des_enable, all_des_tstamp_enable
> 
> Okay, so fairly trivial configs.

Yes mostly on/off switches or single values config.

> > 
> > Note that all the existent DEs are discovered at runtime dynamically via
> > SCMI in the background at init/probe and then never change: i.e.
> > the tree is statically created upon discovery, user cannot
> > create/destroy or symlink files at will, nor the backend platform FW
> > running the SCMI server can pop-up new DataEvents after the initial
> > enumeration.
> 
> That makes sense.
> 
> > 
> > All the above configs can also be pre-defined in the FW (at built time)
> > as being default boot-on with predefined values, like a specific
> > boot-on update interval, so that you could have a system in which really
> > you dont need to configure anything...everything is on and you just
> > read data. (unless you want to change config of course...)
> 
> Okay, so the initial value of some parameters might not be "disabled" etc.

Yes at the protocol layer I take care to lookup all of this states at
init so that the initial states are consistent with what exposed...

> 
> I guess, from a user space perspective, reading should be allowed by everyone
> but writing should be limited to root?
>

Yes it is currently world readable and only root has write access by default,
BUT in this latest V4 I added (as asked by some internal team) handling of the
usual uid/gid/umask mount options so that a privileged user can change the ownership
policy at mount time. (not supporting anyway FS_USERNS_MOUNT since it does not
make sense to support containers for SCMI Telemetry)

> > 
> > There is more stuff that indeed is configurable per the SCMI spec
> > but these additional params are hidden into the SCMI Telemetry protocol
> > layer (the initial patches in this series) and NOT made available to
> > the driver/users of the protocol (like the SCMI FS driver that sits on
> > top)
> 
> Do you assume that there will get significantly more config options added in the
> future for user space to configure?

No, I dont think so...the only planned extensions were to support more
performant read access mechanisms, i.e. direct mmap'ability of FW/Kernel
SCMI Telemetry shared memory areas...BUT that will immediately dump all
the bulk of the lower layer protocol work into the tools domain...and
we're not ready to do so...beside having one more thing, the tool, to keep
in sync with possible future spec changes (unless exposing even more stuff
like tlm mem-areas accessors to the UAPI...that would be painful kernel
side and not desired AFAIU...)

> 
> > 
> > IOW, this humonguos series (~8k lines) is only partially composed by
> > the Filesystem driver (~3k): the bulk of the Telemetry logic and SCMI
> > message exchanges are contained in the SCMI Protocol stack which has
> > been extended to support the Telemerty protocol at first
> > (the 'firmware: arm_scmi:' initial patches).
> > 
> > This latter common support is exposed by the SCMI stack for the SCMI
> > drivers to use via custom per-protocol operations (not an orginal name :P)
> > exposed in include/linux/scmi_protocol.h
> > 
> > So when you write into FS to configure smth, you end up calling an internal
> > tlm_proto_ops that in turn will cause an SCMI message to be sent
> > (in some cases say to enable a DE or set the update interval)
> 
> Makes sense.
> 
> > 
> > When you read something, you end up calling another Telemetry operation
> > that in turn returns you the DataEvent value you were looking for...how
> > this is retrieved via SCMI in the background is transparent to the
> > FS driver because, again, these details are buried into the protocol
> > layer. Talking about reads, you can:
> > 
> >  - read a single value from des/0x<NNNN>/value
> >  - read ALL the currently enabled DE in a bulk read via des_bulk_read
> > 
> > ...most of the other entries in the tree are simply RO properties of the DEs
> > that have been discovered at enumeration time.
> 
> Is this bulk-reading relevant for performance or just a "nice to have" ?
> 

I suppose depends on your usage pattern: it is definitely relevant
because the main collection mechanism are shared memory areas (SHMTIs)
between the platform firmware and the Kernel: such areas being accessed
from 2 differnt worlds concurrently come with a SCMI-specified
synchro/consistency mechanism based simply on a pair of sequence numbers
placed at the start and at the end of the SHMTI, so that the FW increases
such magic numbers in a well-known way before and after updating the SHMTI
values, so that the kernel can detect (without any interlocking mechanism)
if a platform write happened in the middle of its reads...

...so if you read one single DE 64bit value, under the hood the kernel
would have had to really perform at leats 3 reads from the SHMTI to check
the consistecy of that single read...

... while if you do a bulk_read the overhead due to the consistecy
checks gets 'spread' across a number of DEs because the kernel will snapshot
the whole SHMTIs (potentially KBytes) between the 2 consistency reads

...the good side effect of all of this is that I can leverage such
sequence number to optimize reads..i.e. do NOT even try to read anything
if the new sequnce number is unchanged from the last one I cached on the
last successfull read of this value...

So at the end I would say it is NOT simply a nice to have BUT it is
certainly only the first step towards a more performant alternative access
(like with mmaps)...it depends on the usage pattern...I am not sure what
mechanism is used by our tools more...

> 
> > 
> > Given that walking a FS tree and issuing configuration as writes is NOT
> > performant really (nor handy if you are not a human), currently, even
> > in this FS-based series you can really perform all of the discovery AND
> > the configuration tasks WITHOUT walking the filesystem tree, but instead
> > issuing a bunch of IOCTLs issued on a special 'control' file that I
> > embedded in the FS. Such UAPI IOCTLs described at:
> 
> Makes sense.
> 
> > 
> > https://lore.kernel.org/arm-scmi/20260612223802.1337232-6-cristian.marussi@arm.com/T/#u
> >  
> > So my plan of action in order to get rid of the FS in-kenel implementation
> > would be to drop this Filesystem in favour of simple character devices
> > and move the existent IOCTLs interface (revisited where needed) on top of
> > these devices: that way you will be able to use IOCTLs to enumerate the
> > Telemetry sources and then configure them.
> > 
> > Read will then happen (probably) leveraging a number of chardev fops like:
> > IOCTLs, .read and .mmap...up to the tool decide what to use.
> > 
> > After this porting to chardev is done, I would start optionally exposing
> > again all of this in a human-readable alternative way by adding a layer
> > of FUSE on top of this chardev interface.
> 
> Yes. How high-priority is the fs side? Or would a tool using a library to access
> this information also work in the first step?
> 

I have to sync with tools on this...because they are stiil probably
using currently the FS, but it was already planned for the future to move to
a more low level access (ioctl/mmap)...

...my aim would be, at this point, to favour this transition without sudden
breaking their current world (and have to expatriate :P)

..from my personal point of view, I would certainly like to still have the
FUSE layer for ease of testing and verification on my side...but it is just
a nice to have... 

> > 
> > Basically my aim is to drop the FS implementation from the kernel, as
> > advised, while trying to optionally make it still available via a userspace
> > FUSE implementation...IOW the intention would be for the next V5 to expose
> > the same interfaces as V4 but with the help of a tool instead that builds,
> > if wanted, a FUSE mount built on top of the chardev interface.

[snip]

> >>
> >> It's a good question how that could be done, if you need more information about
> >> these events from user space.
> > 
> > I have NOT really delved into that, so as of know we do NOT fed any data
> > to existing Kernel subsystems, not there is any available in-kernel
> > interface to consume DE data (nobody asked), but, I can imagine 2 solution:
> > 
> >  - our beloved architects decide to 'architect' more DataEvents in the
> >    next version of the spec.. i.e. they reserve some specific DE IDs to
> >    represent some well defined entity (like it is done already in the spec
> >    for a dozen IDs)...this avoids the needs of any new interface all
> >    together
> 
> That would be the cleanest solution :)
> 

Definitely agree.

> > 
> > OR
> > 
> > - we open some sort of user-->kernel ABI channel 'somewhere' where the
> >   userspace tool, interpreting the JSON description, can communicate something
> >   like " on this platform ID 1,2,3,4 should be fed to the IIO sensors frmwk
> >   too, while ID 39,8,76 can be fed to HWMON..." etc
> > 
> >>
> >> [...]
> >>
> >>
> >> That sounds reasonable.
> >>
> >> [...]
> >>

[snip]

> > Regarding the user concurrency, I have already explicitly pushed back on
> > this, our own tools team: any concurrent read or configuration write is
> > allowed and properly handled in a consistent way, BUT on the configuration
> > side the last write/ioctl wins: there is NO in-kernel OR userspace
> > co-ordination provided out of the box: IOW if you use multiple tools
> > concurrently to apply conflicting configurations, it is none of our problem
> 
> Would concurrent reading work? I assume so, right?
> 

Yes concurrent reading is not a problem, and concurrent writes are
properly handled at the write/message level (i.e. no corruption) BUT
no co-ordination is provided from the kernel on those config writes,
last write wins.

> > 
> > ...similarly as if you have an actively running network configuration daemon
> > and you try to set your IP manually...nobody will prevent you from doing this,
> > the same netlink will be used freely by you on the shell and the daemon (if you
> > have enough privilege), but you will gonna have unexpected result...
> > 
> > I dont either see the case to enforce exclusive access for Telemetry resources:
> > co-ordination is up to the user in my view...I mean if you have 2 tools
> > configuring concurrently SCMI telemetry in a conflicting way something has been
> > misconfigured somewhere
> > 
> > .....having said that, I understand that the concurrency co-ordination
> > issue can be particularly tricky to spot and solve in userspace, so I DO
> > expose a generation counter entry that is updated on any configuration
> > change, so that a userspace app using Telemetry can monitor (poll) this
> > counter to spot if someone else on the system is quietly suddenly applying
> > configuration changes...
> 
> Okay, so a single writer (admin) changing stuff could get picked up my possibly
> many concurrent readers?

Mmm...not sure what you mean here...

If you configure your Telemetry as you desire and start collecting data via
readers, BUT then some other process changes configs under your belt, that is
allowed as said, and so your analisys could be impacted...(something turned off
as an example, or update interval changed)...

...so while this is NOT regulated/co-ordinated by the Kernel, in order to
ease the detection of such events by your reading process, I provide a pollable
entry that returns an integer and then blocks until such counter is next updated
by an intervening under-the-hood configuration change...so you can configure,
monitor the generatin counter and then starts reading you data, sure that you
will detect any conflicting re-config issued by a rougue process...
(and I have to still extend this event polling mechanism to use a user
provided eventfd...since it was NOT strictly needed...but now with
IOCTLs interface I will add that too...)

> 
> > 
> >>>
> >>> Should/could such a tool live in the kernel tree (tools/) at least for
> >>> ease of development/deployment ?
> >>
> >> I think OOT.
> >>
> > 
> > Ok.
> > 
> > Sorry for the long email..I hope I have clarified the situation, anyway
> > I am already moving to get rid of the in-kernel interface as advised in
> > favour of a chardev kernel interface and an optional FUSE based FS...
> 
> Yes, thank you a lot, I hope it also helps Christian to help push this into the
> right direction!
>

Thanks a lot, David !
Cristian


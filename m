Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DA718027;
	Thu, 18 Jun 2026 23:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781825322; cv=none; b=PiHIt/ZSz8fELD/e/b2y+h5LImJnrMVBMWzcw92jSHfgnGvNfBxI9WvT5jqTQ1bzVnff5E2mH+i1j5GGZnE7CrE2M1Ld1AkQW/ZC1Za2M8iY2LfhZ4scTWoUUwTwWHj3/8s0QbKixa8MlyTwuNAMKDVGKs3cix2DNIeBVeq/fIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781825322; c=relaxed/simple;
	bh=PzM/pg0pq8aj0UlPOvPi0UDHqIF+qYiy4olYFWZPx+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjmTlmIOwfP0+xhq7KDxx5FjThC5lu/VenWupPC9gs5xHKb0fC6nyjLsuQSjTVVNmQY0DCeXfVh4ZAJ+2Q7oXIqiOpR3mpkAgZXzVHROQYdsCpt2krpyZy7ZPpTOUqDMQmdSU+E0ZG1Je98oyqnoZMjY1uZb0lm0/G07kDYFWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tFr8CwUM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tFr8CwUM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 857963541;
	Thu, 18 Jun 2026 16:28:33 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 870263F763;
	Thu, 18 Jun 2026 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781825318; bh=PzM/pg0pq8aj0UlPOvPi0UDHqIF+qYiy4olYFWZPx+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFr8CwUMAwV4AeXdmNLe5J4K26ciaFrm7VoKnskCYDKzNAIqrFef+NDqnYWEy//wF
	 B+glpFqGGCNDJa8LFEUnpJUIFhmrxvJHJeZtfRdg/+7kGxm+mpJzPhfTNXrTnSbBFf
	 HKQo/HUaBpiMs2qqCV0sfTyBZVGapVkZN9ZAPqLU=
Date: Fri, 19 Jun 2026 00:28:20 +0100
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
Message-ID: <ajR_FBWOoXJKSeoH@pluto>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
 <20260617-waten-allabendlich-zueinander-93d4b1367b8c@brauner>
 <ajLVW1eHzbGDm4yn@pluto>
 <29a304f0-1e62-418a-b84f-aabdc4c0de8d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29a304f0-1e62-418a-b84f-aabdc4c0de8d@kernel.org>

On Thu, Jun 18, 2026 at 07:22:29PM +0200, David Hildenbrand (Arm) wrote:
> Hi,

Hi David,

> 
> asking some clarifying questions that I assume also Christian might want to know.
> 

Thanks for having a look !

> >>> In a nutshell, the SCMI Telemetry protocol allows an agent to discover at
> >>> runtime the set of Telemetry Data Events (DEs) available on a specific
> >>> platform and provides the means to configure the set of DEs that a user is
> 
> Is the configuration aspect limited to enabling selected events, or is there
> more that can be configured?
>

The needed configuration is:

 - global Telemetry enable (tlm_enable)
 - global common update_interval (current_update_interval)
 - per-DE enable/disable (des/0x<NNNN>/enable)
 - per-DE timestamping enable/disable (des/0x<NNNN>/tstamp_enable)

 ... then there are a couple of handy catch-all entries:
	all_des_enable, all_des_tstamp_enable

Note that all the existent DEs are discovered at runtime dynamically via
SCMI in the background at init/probe and then never change: i.e.
the tree is statically created upon discovery, user cannot
create/destroy or symlink files at will, nor the backend platform FW
running the SCMI server can pop-up new DataEvents after the initial
enumeration.

All the above configs can also be pre-defined in the FW (at built time)
as being default boot-on with predefined values, like a specific
boot-on update interval, so that you could have a system in which really
you dont need to configure anything...everything is on and you just
read data. (unless you want to change config of course...)

There is more stuff that indeed is configurable per the SCMI spec
but these additional params are hidden into the SCMI Telemetry protocol
layer (the initial patches in this series) and NOT made available to
the driver/users of the protocol (like the SCMI FS driver that sits on
top)

IOW, this humonguos series (~8k lines) is only partially composed by
the Filesystem driver (~3k): the bulk of the Telemetry logic and SCMI
message exchanges are contained in the SCMI Protocol stack which has
been extended to support the Telemerty protocol at first
(the 'firmware: arm_scmi:' initial patches).

This latter common support is exposed by the SCMI stack for the SCMI
drivers to use via custom per-protocol operations (not an orginal name :P)
exposed in include/linux/scmi_protocol.h

So when you write into FS to configure smth, you end up calling an internal
tlm_proto_ops that in turn will cause an SCMI message to be sent
(in some cases say to enable a DE or set the update interval)

When you read something, you end up calling another Telemetry operation
that in turn returns you the DataEvent value you were looking for...how
this is retrieved via SCMI in the background is transparent to the
FS driver because, again, these details are buried into the protocol
layer. Talking about reads, you can:

 - read a single value from des/0x<NNNN>/value
 - read ALL the currently enabled DE in a bulk read via des_bulk_read

...most of the other entries in the tree are simply RO properties of the DEs
that have been discovered at enumeration time.

Given that walking a FS tree and issuing configuration as writes is NOT
performant really (nor handy if you are not a human), currently, even
in this FS-based series you can really perform all of the discovery AND
the configuration tasks WITHOUT walking the filesystem tree, but instead
issuing a bunch of IOCTLs issued on a special 'control' file that I
embedded in the FS. Such UAPI IOCTLs described at:

https://lore.kernel.org/arm-scmi/20260612223802.1337232-6-cristian.marussi@arm.com/T/#u
 
So my plan of action in order to get rid of the FS in-kenel implementation
would be to drop this Filesystem in favour of simple character devices
and move the existent IOCTLs interface (revisited where needed) on top of
these devices: that way you will be able to use IOCTLs to enumerate the
Telemetry sources and then configure them.

Read will then happen (probably) leveraging a number of chardev fops like:
IOCTLs, .read and .mmap...up to the tool decide what to use.

After this porting to chardev is done, I would start optionally exposing
again all of this in a human-readable alternative way by adding a layer
of FUSE on top of this chardev interface.

Basically my aim is to drop the FS implementation from the kernel, as
advised, while trying to optionally make it still available via a userspace
FUSE implementation...IOW the intention would be for the next V5 to expose
the same interfaces as V4 but with the help of a tool instead that builds,
if wanted, a FUSE mount built on top of the chardev interface.

So basically 'floating up' the current FS-like interface into userspace.

> >>> interested into, while reading them back using the collection method that
> >>> is deeemed more suitable for the usecase at hand. (...amongst the various
> >>> possible collection methods allowed by SCMI specification)
> >>>
> >>> Without delving into the gory details of the whole SCMI Telemetry protocol
> >>> let's just say that the SCMI platform/server firmware advertises a number
> >>> of Telemetry Data Events, each one identified by a 32bit unique ID, and an
> >>> SCMI agent/client, like Linux, can discover them and read back at will the
> >>> associated data value in a number of ways.
> >>> Data collection is mainly intended to happen on demand via shared memory
> >>> areas exposed by the platform firmware, discovered dynamically via SCMI
> >>> Telemetry and accessed by Linux on-demand, but some DE can also be reported
> >>> via SCMI Notifications asynchronous messages or via direct dedicated
> >>> FastChannels (another kind of SCMI memory based access): all of this
> >>> underlying mechanism is anyway hidden to the user since it is mediated by
> >>> the kernel driver which will return the proper data value when queried.
> >>>
> >>> Anyway, the set of well-known architected DE IDs defined by the spec is
> >>> limited to a dozen IDs, which means that the vast majority of DE IDs are
> >>> customizable per-platform: as a consequence, though, the same ID, say
> >>> '0x1234', could represent completely different things on different systems.
> >>>
> >>> Precise definitions and semantic of such custom Data Event IDs are out of
> >>> the scope of the SCMI Telemetry specification and of this implementation:
> >>> they are supposed to be provided using some kind of JSON-like description
> >>> file that will have to be consumed by a userspace tool which would be
> >>> finally in charge of making sense of the set of available DEs.
> 
> You mention json here ... but I assume the data we are getting fed by the
> protocol is not in some default format? (e.g., json)

The data format is defined by the SCMI spec and it is buried in the SCMI
layer, there are a number of collection method and a number of formats: this
is NOT exposed from the SCMI core BUT handled transparently.

The raw spec format basically defines how DE ID, Tstamps, values are represented
in memory and how their consistency can be assured despite the fact that
platform could update the same entries that a user is concurrently reading...

JSON definitions only assign a semantic to the DEs (in theory...): e.g. on this
specific platform...wth is 0x1234 ? ..also note that JSON defs are NOT part of
the spec....they do NOT really exist for the Kernel: they are parsed and
interpreted by more complex user space tools that are supposed to leverage some
of these interfaces to retrieve data and carry-on analysis.

> 
> >>>
> >>> IOW, in turn, this means that even though the DEs enumerated via SCMI come
> >>> with some sort of topological and qualitative description provided by the
> >>> protocol (like unit of measurements, name, topology info etc), kernel-wise
> >>> we CANNOT be completely sure of "what is what" without being fed-back some
> >>> sort of information about the DEs by the afore mentioned userspace tool.
> 
> Maybe you have it in some of the patches here, but what does the typical
> directory + file structure look like in the current implementation?
> 
> Do you have an example?
> 
> Also, is everything in that filesystem read-only, or are there some writable
> file (IOW, how is stuff configured?).

See above for config/write entry ... and I think you found the FS layout in the
doc already...

> 
> >>>
> >>> For these reasons, currently this series does NOT attempt to register any
> >>> of these DEs with any of the usual in-kernel subsystems (like HWMON, IIO,
> >>> PERF etc), simply because we cannot be sure which DE is suitable, or even
> >>> desirable, for a given subsystem. This also means there are NO in-kernel
> >>> users of these Telemetry data events as of now.
> 
> Okay, so you really only feed this data to user space, exposing all the data you
> have easily available as part of the protocol.

Yes, no interpetation nor filtering: I expose all that have enumerated and/
discovered by the protocol, allowing for configurations while hiding the inner
SCMI Telemetry mechanism...

> 
> >>>
> >>> So, while we do not exclude, for the future, to feed/register some of the
> >>> discovered DEs to/with some of the above mentioned Kernel subsystems, as
> >>> of now we have ONLY modeled a custom userspace API to make SCMI Telemetry
> >>> available to userspace tools.
> 
> It's a good question how that could be done, if you need more information about
> these events from user space.

I have NOT really delved into that, so as of know we do NOT fed any data
to existing Kernel subsystems, not there is any available in-kernel
interface to consume DE data (nobody asked), but, I can imagine 2 solution:

 - our beloved architects decide to 'architect' more DataEvents in the
   next version of the spec.. i.e. they reserve some specific DE IDs to
   represent some well defined entity (like it is done already in the spec
   for a dozen IDs)...this avoids the needs of any new interface all
   together

OR

- we open some sort of user-->kernel ABI channel 'somewhere' where the
  userspace tool, interpreting the JSON description, can communicate something
  like " on this platform ID 1,2,3,4 should be fed to the IIO sensors frmwk
  too, while ID 39,8,76 can be fed to HWMON..." etc

> 
> >>>
> >>> In deciding which kind of interface to expose SCMI Telemetry data to a
> >>> user, this new SCMI Telemetry driver aims at satisfying 2 main reqs:
> >>>
> >>>  - exposing an FS-based human-readable interface that can be used to
> >>>    discover, configure and access our Telemetry data directly also from
> >>>    the shell without special tools
> >>>
> >>>  - exposing alternative machine-friendly, more-performant, binary
> >>>    interfaces that can be used to avoid the overhead of multiple accesses
> >>>    to the VFS and that can be more suitable to access with custom tools
> [...]
> 
> >>>
> >>> Due to the above reasoning, since V1 we opted for a new approach with the
> >>> proposed interfaces now based on a full fledged, unified, virtual pseudo
> >>> filesystem implemented from scratch, so that we can:
> >>>
> >>>  - expose all the DEs property we like as before with SysFS, but without
> >>>    any of the constraint imposed by the usage of SysFs or kernfs.
> >>>
> >>>  - easily expose additional alternative views of the same set of DEs
> >>>    using symlinking capabilities (e.g. alternative topological view)
> 
> That sounds reasonable.
> 
> [...]
> 
> > ...I would not say that this was the kind of feedback I was hoping for,
> > but I am NOT gonna argue, given that you shot down already what I thought
> > were all my best selling points :P
> > 
> > At this point my understanding is that the way forward must be to use
> > a custom tool to configure/extract/translate the raw Telemetry data and
> > move up into userspace the whole human readable FS layer via FUSE, if
> > really needed.
> > 
> > I suppose that the new kernel/user interface has to be some dedicated char
> > device implementing proper fops. (like I did previously in early versions
> > of this series and then abandoned...)
> > 
> > Is this you have in mind ? Dedicated character device(s) with enough fops
> > to be able to configure/extract Telemetry data with a custom tool ?
> 
> I cannot speak for Christian, but I guess you could have some kind of libscmi in
> user space that can obtain the information (as you say, probably char device,
> not sure which alternatives we have), to expose the data through a nice ABI, to
> then either make tools build upon that directly, or have a fuse server in user
> space that mimics what you currently do with the file system.

My aim would be at first a simple tool that can exercise the chardev interface to
discover configure and read back data, and then a FUSE server on top of this to
optionally expose the human readable FS....I suppose our internal and external
customers can use the FS interface to validate/test/script on one side, OR
simply code their own tools/libs to use directly the bare chardev inteface...

...we do have a tools team already working on a library to ease all of this
SCMI Telemtry collection and analysis...it is just a matter to re-target the
kind of lower level interfaces that they are using in the near future
probably (they were already planning indeed AFAIK to use more performant
interface that FS...)

> 
> One thing that is not clear to me yet is how stuff would be configured, and how
> possibly multiple users of libscmi would possibly interact.
> 

Configuration/discovery will happen via IOCTls, while consuming the Data
can happen:

 - all together in bulk via a device read fops
 - a single DE via a targeted IOCTL
 - direct access to the raw SCMI data via dev/mmap of the underlying SCMI
   areas (that means the tool has to parse the SCMI format defined by the
   spec on its own, without the currently provided Kernel mediation...)

Regarding the user concurrency, I have already explicitly pushed back on
this, our own tools team: any concurrent read or configuration write is
allowed and properly handled in a consistent way, BUT on the configuration
side the last write/ioctl wins: there is NO in-kernel OR userspace
co-ordination provided out of the box: IOW if you use multiple tools
concurrently to apply conflicting configurations, it is none of our problem

...similarly as if you have an actively running network configuration daemon
and you try to set your IP manually...nobody will prevent you from doing this,
the same netlink will be used freely by you on the shell and the daemon (if you
have enough privilege), but you will gonna have unexpected result...

I dont either see the case to enforce exclusive access for Telemetry resources:
co-ordination is up to the user in my view...I mean if you have 2 tools
configuring concurrently SCMI telemetry in a conflicting way something has been
misconfigured somewhere

.....having said that, I understand that the concurrency co-ordination
issue can be particularly tricky to spot and solve in userspace, so I DO
expose a generation counter entry that is updated on any configuration
change, so that a userspace app using Telemetry can monitor (poll) this
counter to spot if someone else on the system is quietly suddenly applying
configuration changes...

> > 
> > Should/could such a tool live in the kernel tree (tools/) at least for
> > ease of development/deployment ?
> 
> I think OOT.
> 

Ok.

Sorry for the long email..I hope I have clarified the situation, anyway
I am already moving to get rid of the in-kernel interface as advised in
favour of a chardev kernel interface and an optional FUSE based FS...

Any further feedback is welcome...

Thanks,
Cristian

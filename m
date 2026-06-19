Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD137206E;
	Fri, 19 Jun 2026 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864231; cv=none; b=Q7IirGOaYyIDfjOxgmn5czqhmFvYYO8IHAdC7kMZ3+OT/+i0l1ccEeVXE++jN0TvzIUQsiqHsEzFhTAYJOpJUAWm4Q77h1aRuD91ad8rAHcZ0mHOq0MKIdmHCtuOrrecbVg3W4axnvu959at0yhcoj7g2D3A1bo37I1hxVO9h4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864231; c=relaxed/simple;
	bh=U+eJJ0Pk4v7h9YrnqUedOGWuFpbzHdDrImqh/mGPSSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aS22frWLQ+y1R3xrKorgx3Q3GZ3PNmGxpvCX3WnMQP+i4TylU3yvvRxXXkU0bzJcfEPlWOMS9iaPuj6MbZ1j1aKLqf/857HDy7fvi3pOgI1fpr2Y59s1SiImOaUP1ZVTjnU3PbGx2XGTXERd26ERk2OznE/VzsKJiB+q/Sh4QQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDuY2N3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDuY2N3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94101F000E9;
	Fri, 19 Jun 2026 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781864227;
	bh=8lMxMm7M/YOdPwZV8is1XfFR+rHGFTkhsnW+cNjJY90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EDuY2N3ha5DPACdxu6vVPmXACO+wwqhe0ePBdTIjTepYVKuz42NzveH8sST3rF236
	 YPAHtOPsoKQzDknFTAT4maYWp24TLJMTw9Hj9domP0I9Eh9Qiz1tlMCo6xXjT2SKBz
	 d9tEz+e50BRrgV3M7MwW1ApfbFEFnIxBHbPdagaehIFPPR1gky1A9zm54P2aDJ2Iq1
	 +TtAxENYy8yR5h9W2NxWC9aw3lXSxN+jt2zsjtrTnsRSxqVTCfW1uwXwJn7DgrTTqX
	 MQmP4OkhACWPppDKiX+C55TMaHHsr4EhsdZFzjyDgoN2VOSs0cmd32AJQQ1AuTJj+u
	 Wsu/rko3v182g==
Message-ID: <0025b907-27b9-4a51-b78f-f8ad413644d0@kernel.org>
Date: Fri, 19 Jun 2026 12:16:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/31] Introduce SCMI Telemetry FS support
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 sudeep.holla@kernel.org, james.quinlan@broadcom.com, f.fainelli@gmail.com,
 vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com,
 michal.simek@amd.com, d-gole@ti.com, jic23@kernel.org, elif.topuz@arm.com,
 lukasz.luba@arm.com, philip.radford@arm.com, souvik.chakravarty@arm.com,
 leitao@kernel.org, kas@kernel.org, puranjay@kernel.org,
 usama.arif@linux.dev, kernel-team@meta.com
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
 <20260617-waten-allabendlich-zueinander-93d4b1367b8c@brauner>
 <ajLVW1eHzbGDm4yn@pluto> <29a304f0-1e62-418a-b84f-aabdc4c0de8d@kernel.org>
 <ajR_FBWOoXJKSeoH@pluto>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ajR_FBWOoXJKSeoH@pluto>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>> Is the configuration aspect limited to enabling selected events, or is there
>> more that can be configured?
>>
> 
> The needed configuration is:
> 
>  - global Telemetry enable (tlm_enable)
>  - global common update_interval (current_update_interval)

Okay, so simple global properties.

>  - per-DE enable/disable (des/0x<NNNN>/enable)
>  - per-DE timestamping enable/disable (des/0x<NNNN>/tstamp_enable)
> 
>  ... then there are a couple of handy catch-all entries:
> 	all_des_enable, all_des_tstamp_enable

Okay, so fairly trivial configs.
> 
> Note that all the existent DEs are discovered at runtime dynamically via
> SCMI in the background at init/probe and then never change: i.e.
> the tree is statically created upon discovery, user cannot
> create/destroy or symlink files at will, nor the backend platform FW
> running the SCMI server can pop-up new DataEvents after the initial
> enumeration.

That makes sense.

> 
> All the above configs can also be pre-defined in the FW (at built time)
> as being default boot-on with predefined values, like a specific
> boot-on update interval, so that you could have a system in which really
> you dont need to configure anything...everything is on and you just
> read data. (unless you want to change config of course...)

Okay, so the initial value of some parameters might not be "disabled" etc.

I guess, from a user space perspective, reading should be allowed by everyone
but writing should be limited to root?

> 
> There is more stuff that indeed is configurable per the SCMI spec
> but these additional params are hidden into the SCMI Telemetry protocol
> layer (the initial patches in this series) and NOT made available to
> the driver/users of the protocol (like the SCMI FS driver that sits on
> top)

Do you assume that there will get significantly more config options added in the
future for user space to configure?

> 
> IOW, this humonguos series (~8k lines) is only partially composed by
> the Filesystem driver (~3k): the bulk of the Telemetry logic and SCMI
> message exchanges are contained in the SCMI Protocol stack which has
> been extended to support the Telemerty protocol at first
> (the 'firmware: arm_scmi:' initial patches).
> 
> This latter common support is exposed by the SCMI stack for the SCMI
> drivers to use via custom per-protocol operations (not an orginal name :P)
> exposed in include/linux/scmi_protocol.h
> 
> So when you write into FS to configure smth, you end up calling an internal
> tlm_proto_ops that in turn will cause an SCMI message to be sent
> (in some cases say to enable a DE or set the update interval)

Makes sense.

> 
> When you read something, you end up calling another Telemetry operation
> that in turn returns you the DataEvent value you were looking for...how
> this is retrieved via SCMI in the background is transparent to the
> FS driver because, again, these details are buried into the protocol
> layer. Talking about reads, you can:
> 
>  - read a single value from des/0x<NNNN>/value
>  - read ALL the currently enabled DE in a bulk read via des_bulk_read
> 
> ...most of the other entries in the tree are simply RO properties of the DEs
> that have been discovered at enumeration time.

Is this bulk-reading relevant for performance or just a "nice to have" ?


> 
> Given that walking a FS tree and issuing configuration as writes is NOT
> performant really (nor handy if you are not a human), currently, even
> in this FS-based series you can really perform all of the discovery AND
> the configuration tasks WITHOUT walking the filesystem tree, but instead
> issuing a bunch of IOCTLs issued on a special 'control' file that I
> embedded in the FS. Such UAPI IOCTLs described at:

Makes sense.

> 
> https://lore.kernel.org/arm-scmi/20260612223802.1337232-6-cristian.marussi@arm.com/T/#u
>  
> So my plan of action in order to get rid of the FS in-kenel implementation
> would be to drop this Filesystem in favour of simple character devices
> and move the existent IOCTLs interface (revisited where needed) on top of
> these devices: that way you will be able to use IOCTLs to enumerate the
> Telemetry sources and then configure them.
> 
> Read will then happen (probably) leveraging a number of chardev fops like:
> IOCTLs, .read and .mmap...up to the tool decide what to use.
> 
> After this porting to chardev is done, I would start optionally exposing
> again all of this in a human-readable alternative way by adding a layer
> of FUSE on top of this chardev interface.

Yes. How high-priority is the fs side? Or would a tool using a library to access
this information also work in the first step?

> 
> Basically my aim is to drop the FS implementation from the kernel, as
> advised, while trying to optionally make it still available via a userspace
> FUSE implementation...IOW the intention would be for the next V5 to expose
> the same interfaces as V4 but with the help of a tool instead that builds,
> if wanted, a FUSE mount built on top of the chardev interface.
> 
> So basically 'floating up' the current FS-like interface into userspace.

Yes.

> 
>>
>> You mention json here ... but I assume the data we are getting fed by the
>> protocol is not in some default format? (e.g., json)
> 
> The data format is defined by the SCMI spec and it is buried in the SCMI
> layer, there are a number of collection method and a number of formats: this
> is NOT exposed from the SCMI core BUT handled transparently.
> 
> The raw spec format basically defines how DE ID, Tstamps, values are represented
> in memory and how their consistency can be assured despite the fact that
> platform could update the same entries that a user is concurrently reading...
> 
> JSON definitions only assign a semantic to the DEs (in theory...): e.g. on this
> specific platform...wth is 0x1234 ? ..also note that JSON defs are NOT part of
> the spec....they do NOT really exist for the Kernel: they are parsed and
> interpreted by more complex user space tools that are supposed to leverage some
> of these interfaces to retrieve data and carry-on analysis.

What I thought, thanks.

> 
>>
>>
>> Maybe you have it in some of the patches here, but what does the typical
>> directory + file structure look like in the current implementation?
>>
>> Do you have an example?
>>
>> Also, is everything in that filesystem read-only, or are there some writable
>> file (IOW, how is stuff configured?).
> 
> See above for config/write entry ... and I think you found the FS layout in the
> doc already...
> 
>>
>>
>> Okay, so you really only feed this data to user space, exposing all the data you
>> have easily available as part of the protocol.
> 
> Yes, no interpetation nor filtering: I expose all that have enumerated and/
> discovered by the protocol, allowing for configurations while hiding the inner
> SCMI Telemetry mechanism...
> 
>>
>>
>> It's a good question how that could be done, if you need more information about
>> these events from user space.
> 
> I have NOT really delved into that, so as of know we do NOT fed any data
> to existing Kernel subsystems, not there is any available in-kernel
> interface to consume DE data (nobody asked), but, I can imagine 2 solution:
> 
>  - our beloved architects decide to 'architect' more DataEvents in the
>    next version of the spec.. i.e. they reserve some specific DE IDs to
>    represent some well defined entity (like it is done already in the spec
>    for a dozen IDs)...this avoids the needs of any new interface all
>    together

That would be the cleanest solution :)

> 
> OR
> 
> - we open some sort of user-->kernel ABI channel 'somewhere' where the
>   userspace tool, interpreting the JSON description, can communicate something
>   like " on this platform ID 1,2,3,4 should be fed to the IIO sensors frmwk
>   too, while ID 39,8,76 can be fed to HWMON..." etc
> 
>>
>> [...]
>>
>>
>> That sounds reasonable.
>>
>> [...]
>>
>>> ...I would not say that this was the kind of feedback I was hoping for,
>>> but I am NOT gonna argue, given that you shot down already what I thought
>>> were all my best selling points :P
>>>
>>> At this point my understanding is that the way forward must be to use
>>> a custom tool to configure/extract/translate the raw Telemetry data and
>>> move up into userspace the whole human readable FS layer via FUSE, if
>>> really needed.
>>>
>>> I suppose that the new kernel/user interface has to be some dedicated char
>>> device implementing proper fops. (like I did previously in early versions
>>> of this series and then abandoned...)
>>>
>>> Is this you have in mind ? Dedicated character device(s) with enough fops
>>> to be able to configure/extract Telemetry data with a custom tool ?
>>
>> I cannot speak for Christian, but I guess you could have some kind of libscmi in
>> user space that can obtain the information (as you say, probably char device,
>> not sure which alternatives we have), to expose the data through a nice ABI, to
>> then either make tools build upon that directly, or have a fuse server in user
>> space that mimics what you currently do with the file system.
> 
> My aim would be at first a simple tool that can exercise the chardev interface to
> discover configure and read back data, and then a FUSE server on top of this to
> optionally expose the human readable FS....I suppose our internal and external
> customers can use the FS interface to validate/test/script on one side, OR
> simply code their own tools/libs to use directly the bare chardev inteface...
> 
> ...we do have a tools team already working on a library to ease all of this
> SCMI Telemtry collection and analysis...it is just a matter to re-target the
> kind of lower level interfaces that they are using in the near future
> probably (they were already planning indeed AFAIK to use more performant
> interface that FS...)

Good.

> 
>>
>> One thing that is not clear to me yet is how stuff would be configured, and how
>> possibly multiple users of libscmi would possibly interact.
>>
> 
> Configuration/discovery will happen via IOCTls, while consuming the Data
> can happen:
> 
>  - all together in bulk via a device read fops
>  - a single DE via a targeted IOCTL
>  - direct access to the raw SCMI data via dev/mmap of the underlying SCMI
>    areas (that means the tool has to parse the SCMI format defined by the
>    spec on its own, without the currently provided Kernel mediation...)
> 
> Regarding the user concurrency, I have already explicitly pushed back on
> this, our own tools team: any concurrent read or configuration write is
> allowed and properly handled in a consistent way, BUT on the configuration
> side the last write/ioctl wins: there is NO in-kernel OR userspace
> co-ordination provided out of the box: IOW if you use multiple tools
> concurrently to apply conflicting configurations, it is none of our problem

Would concurrent reading work? I assume so, right?

> 
> ...similarly as if you have an actively running network configuration daemon
> and you try to set your IP manually...nobody will prevent you from doing this,
> the same netlink will be used freely by you on the shell and the daemon (if you
> have enough privilege), but you will gonna have unexpected result...
> 
> I dont either see the case to enforce exclusive access for Telemetry resources:
> co-ordination is up to the user in my view...I mean if you have 2 tools
> configuring concurrently SCMI telemetry in a conflicting way something has been
> misconfigured somewhere
> 
> .....having said that, I understand that the concurrency co-ordination
> issue can be particularly tricky to spot and solve in userspace, so I DO
> expose a generation counter entry that is updated on any configuration
> change, so that a userspace app using Telemetry can monitor (poll) this
> counter to spot if someone else on the system is quietly suddenly applying
> configuration changes...

Okay, so a single writer (admin) changing stuff could get picked up my possibly
many concurrent readers?

> 
>>>
>>> Should/could such a tool live in the kernel tree (tools/) at least for
>>> ease of development/deployment ?
>>
>> I think OOT.
>>
> 
> Ok.
> 
> Sorry for the long email..I hope I have clarified the situation, anyway
> I am already moving to get rid of the in-kernel interface as advised in
> favour of a chardev kernel interface and an optional FUSE based FS...

Yes, thank you a lot, I hope it also helps Christian to help push this into the
right direction!

-- 
Cheers,

David

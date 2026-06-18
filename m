Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426D313E36;
	Thu, 18 Jun 2026 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803360; cv=none; b=i3laXWVxDsBoBWBGnT+Nnevuj2Z5Lk3C/ELX0R34lrCPbtCnws+oB5XFKWx27H3i9s8DvE8jXgr8+qx47U3wxsUWFF2LHphFMbxciMd5trUR08ZRHi5CTLTC3pLBpM/UrwrOMrN6eEJaZOAgwzTDOXV2IeTK2c/Zmr5i7Zu+1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803360; c=relaxed/simple;
	bh=u89v4memMegfNzL7+VXIs+t1mWmj4gb87bQtc0/n40s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMt/Xc2O9x6Qg5iLlVhYudfBTocBOaTNwcmcCrOaZGa/75/VOgHhTQpkXU5XrKpvzA9qpO55ruwNjbad+NW+bZb2pR8hBoSQf4V8RTy2COcvP0+di/wDATygZSooNt4emHXZIVrnVJJ2hYDYoEn8TY/vOk9NSr6N6K3YS4rKW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaYDLzXF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaYDLzXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524151F000E9;
	Thu, 18 Jun 2026 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781803358;
	bh=CCIZDXXSfPKbcMGZbi4n+59Jp79siugdVFjDNu887cE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RaYDLzXFU5AzdR+NTv8GaIfShr54Ma3m5WaOgGzS91/RCOwSrR9Zch0iZDSyuCY7D
	 2X2CQfHNInWnTp8HTd/+o0yWQ3nnYXLni8vqYHnA/Mel97sMtHdb73Jek+jxwQgwt/
	 fNvXDt/F4JAMoIS7MNGiyhz4Xdua68y5K5ks+05kCThlQVi8PZLzMJOGt4AY/oMFYk
	 R/QszxIt7cM0W8mlbynasyE+YerNS+h7KBZ5F9GsfS9Y00dPm20kNg2gKT1VDgOHEK
	 EcNFMR8G77nZFdNBaj83oEq1RsW/iMuvspFLL83G5Z2gfCAZitGf5phfC+O0+epUKS
	 WQoMaUJB1q9zg==
Message-ID: <29a304f0-1e62-418a-b84f-aabdc4c0de8d@kernel.org>
Date: Thu, 18 Jun 2026 19:22:29 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/31] Introduce SCMI Telemetry FS support
To: Cristian Marussi <cristian.marussi@arm.com>,
 Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, sudeep.holla@kernel.org,
 james.quinlan@broadcom.com, f.fainelli@gmail.com,
 vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com,
 michal.simek@amd.com, d-gole@ti.com, jic23@kernel.org, elif.topuz@arm.com,
 lukasz.luba@arm.com, philip.radford@arm.com, souvik.chakravarty@arm.com,
 leitao@kernel.org, kas@kernel.org, puranjay@kernel.org,
 usama.arif@linux.dev, kernel-team@meta.com
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
 <20260617-waten-allabendlich-zueinander-93d4b1367b8c@brauner>
 <ajLVW1eHzbGDm4yn@pluto>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <ajLVW1eHzbGDm4yn@pluto>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

asking some clarifying questions that I assume also Christian might want to know.

>>> In a nutshell, the SCMI Telemetry protocol allows an agent to discover at
>>> runtime the set of Telemetry Data Events (DEs) available on a specific
>>> platform and provides the means to configure the set of DEs that a user is

Is the configuration aspect limited to enabling selected events, or is there
more that can be configured?

>>> interested into, while reading them back using the collection method that
>>> is deeemed more suitable for the usecase at hand. (...amongst the various
>>> possible collection methods allowed by SCMI specification)
>>>
>>> Without delving into the gory details of the whole SCMI Telemetry protocol
>>> let's just say that the SCMI platform/server firmware advertises a number
>>> of Telemetry Data Events, each one identified by a 32bit unique ID, and an
>>> SCMI agent/client, like Linux, can discover them and read back at will the
>>> associated data value in a number of ways.
>>> Data collection is mainly intended to happen on demand via shared memory
>>> areas exposed by the platform firmware, discovered dynamically via SCMI
>>> Telemetry and accessed by Linux on-demand, but some DE can also be reported
>>> via SCMI Notifications asynchronous messages or via direct dedicated
>>> FastChannels (another kind of SCMI memory based access): all of this
>>> underlying mechanism is anyway hidden to the user since it is mediated by
>>> the kernel driver which will return the proper data value when queried.
>>>
>>> Anyway, the set of well-known architected DE IDs defined by the spec is
>>> limited to a dozen IDs, which means that the vast majority of DE IDs are
>>> customizable per-platform: as a consequence, though, the same ID, say
>>> '0x1234', could represent completely different things on different systems.
>>>
>>> Precise definitions and semantic of such custom Data Event IDs are out of
>>> the scope of the SCMI Telemetry specification and of this implementation:
>>> they are supposed to be provided using some kind of JSON-like description
>>> file that will have to be consumed by a userspace tool which would be
>>> finally in charge of making sense of the set of available DEs.

You mention json here ... but I assume the data we are getting fed by the
protocol is not in some default format? (e.g., json)

>>>
>>> IOW, in turn, this means that even though the DEs enumerated via SCMI come
>>> with some sort of topological and qualitative description provided by the
>>> protocol (like unit of measurements, name, topology info etc), kernel-wise
>>> we CANNOT be completely sure of "what is what" without being fed-back some
>>> sort of information about the DEs by the afore mentioned userspace tool.

Maybe you have it in some of the patches here, but what does the typical
directory + file structure look like in the current implementation?

Do you have an example?

Also, is everything in that filesystem read-only, or are there some writable
file (IOW, how is stuff configured?).

>>>
>>> For these reasons, currently this series does NOT attempt to register any
>>> of these DEs with any of the usual in-kernel subsystems (like HWMON, IIO,
>>> PERF etc), simply because we cannot be sure which DE is suitable, or even
>>> desirable, for a given subsystem. This also means there are NO in-kernel
>>> users of these Telemetry data events as of now.

Okay, so you really only feed this data to user space, exposing all the data you
have easily available as part of the protocol.

>>>
>>> So, while we do not exclude, for the future, to feed/register some of the
>>> discovered DEs to/with some of the above mentioned Kernel subsystems, as
>>> of now we have ONLY modeled a custom userspace API to make SCMI Telemetry
>>> available to userspace tools.

It's a good question how that could be done, if you need more information about
these events from user space.

>>>
>>> In deciding which kind of interface to expose SCMI Telemetry data to a
>>> user, this new SCMI Telemetry driver aims at satisfying 2 main reqs:
>>>
>>>  - exposing an FS-based human-readable interface that can be used to
>>>    discover, configure and access our Telemetry data directly also from
>>>    the shell without special tools
>>>
>>>  - exposing alternative machine-friendly, more-performant, binary
>>>    interfaces that can be used to avoid the overhead of multiple accesses
>>>    to the VFS and that can be more suitable to access with custom tools
[...]

>>>
>>> Due to the above reasoning, since V1 we opted for a new approach with the
>>> proposed interfaces now based on a full fledged, unified, virtual pseudo
>>> filesystem implemented from scratch, so that we can:
>>>
>>>  - expose all the DEs property we like as before with SysFS, but without
>>>    any of the constraint imposed by the usage of SysFs or kernfs.
>>>
>>>  - easily expose additional alternative views of the same set of DEs
>>>    using symlinking capabilities (e.g. alternative topological view)

That sounds reasonable.

[...]

> ...I would not say that this was the kind of feedback I was hoping for,
> but I am NOT gonna argue, given that you shot down already what I thought
> were all my best selling points :P
> 
> At this point my understanding is that the way forward must be to use
> a custom tool to configure/extract/translate the raw Telemetry data and
> move up into userspace the whole human readable FS layer via FUSE, if
> really needed.
> 
> I suppose that the new kernel/user interface has to be some dedicated char
> device implementing proper fops. (like I did previously in early versions
> of this series and then abandoned...)
> 
> Is this you have in mind ? Dedicated character device(s) with enough fops
> to be able to configure/extract Telemetry data with a custom tool ?

I cannot speak for Christian, but I guess you could have some kind of libscmi in
user space that can obtain the information (as you say, probably char device,
not sure which alternatives we have), to expose the data through a nice ABI, to
then either make tools build upon that directly, or have a fuse server in user
space that mimics what you currently do with the file system.

One thing that is not clear to me yet is how stuff would be configured, and how
possibly multiple users of libscmi would possibly interact.

> 
> Should/could such a tool live in the kernel tree (tools/) at least for
> ease of development/deployment ?

I think OOT.

-- 
Cheers,

David

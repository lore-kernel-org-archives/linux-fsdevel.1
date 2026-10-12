Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFD367B8E;
	Mon, 12 Oct 2026 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812590; cv=none; b=oVryBAn2XMQ86DyzGIGI7qyubxm6mI2JP8QPmWmYmn80EKmQEc6g1wDfq0eD5qSZB1UpFVoHCUw9TqdfoeEdowm2K21EwO9axhsJpZzcWoLfjae774YjnPHl0tlhGKLZV0MGlGGtSrpPL4ADifObY3jBAMClfummIoCvAzUmWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812590; c=relaxed/simple;
	bh=iWwtFL33nwhBr2TxEo5kJ4t0XVHuF+g7ikd7bYCStjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDw3v4ILvZlcNOY3oo2bHjnmoPv2DF8vQNxgGTc/4FxC0x1vYsmQ7Hyxd1rOFLHEbox0d29HnJoifmJP+EhTXcCD3Wp/7is5CyBAYxowSvr428Kr6dfUyuZ6i3kmj4ZpUDx/qIOmYV22oUZ1M2SjdIW1ZzwhVf0QdDN1bibRbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii/QJE/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii/QJE/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F791F0089C;
	Mon, 12 Oct 2026 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791812589;
	bh=OJHmGVNn2HLecr4+tdPeYni7+dtQo4+3XwQWbhz+ueA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ii/QJE/ovnSYB8EEd+hUMpSHY8xahakDphfBew/FfZleIK0tg97m8o+863M+26coh
	 vl5hSSPe5HlHrvpw9Ry/DarU5GBXVnk4MnDBgVVNLORkPpFLcM1MWo1Fou+Mi6pf4k
	 eEP/BTHA89jpkxCzdJY4Z14GcF1C/dJCpHdWgW2kCKp3kqWf+3JuW9yYNFd16h23K7
	 0sXble3vXYLZO/FWg3xVLH7A6c2QXORnFjUjH7VmJB2Le8mFx1xGrS/IsuwsePM77l
	 hzUCD7gN0fT9HKEYssmHp36ubUDN6U60IEEyhX/gknSsLhBFxNcqycKu76c8p4t0YU
	 MPBaMY2rkcr7g==
Date: Mon, 12 Oct 2026 15:43:03 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] sysctl: add typed field descriptors
Message-ID: <aszj54qPIdorUTO8@example.org>
References: <cover.1789987960.git.legion@kernel.org>
 <cover.1790439358.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790439358.git.legion@kernel.org>

On Sat, Sep 26, 2026 at 06:22:07PM +0200, Alexey Gladkov wrote:
> Hi,
> 
> Some sysctl users copy an otherwise static ctl_table for each namespace or
> device, then replace data and limit pointers before registration. Besides
> the per-instance allocation, these fixups often depend on table indices:
> reordering an entry without updating the fixup can silently bind it to the
> wrong data or limits.
> 
> This series lets such users describe a table once with static, read-only
> sysctl_field entries. Each field names a data type and an offset into an
> object selected by a sysctl_context at registration time. The offset
> helpers check the member type at build time. Limits and custom handlers
> remain optional properties of a field; the field type does not encode a
> choice of handler or whether limits are present. A subsystem that needs
> more than a namespace can embed sysctl_context in its own registration
> context.
> 
> The sysctl core keeps the context with the table header and materializes
> a ctl_table entry when an existing handler, permission check or BPF hook
> needs one. Legacy ctl_table registrations retain their own path, and
> subsystems can convert tables independently. The IPC, mqueue and ucount
> conversions here remove table copies without changing their backing data.
> 
> Changes since v2:
> 
> - Drop sysctl_uint_vals, as requested by Joel. Existing limit constants
>   suffice for these conversions.
> - Drop the *_MINMAX field types. A field's type now describes its data,
>   while optional min/max pointers supply bounds to the selected handler.
> - Keep __register_sysctl_table() and __register_sysctl_fields() as separate
>   registration paths, sharing only allocation and tree insertion helpers.
> - Address the sashiko findings: avoid calling mode_fn under sysctl_lock,
>   validate the effective maxlen against the context object, and reject
>   NO_DATA fields paired with standard handlers that require data.
> 
> This is the first part of the conversion. Network sysctls and other
> subsystem-specific users will follow in separate series for review by
> their maintainers.
> 
> 
> Alexey Gladkov (5):
>   proc: sysctl: address table entries by index
>   sysctl: add typed field descriptors
>   sysctl: ipc: use typed fields for IPC namespace sysctls
>   sysctl: mq: use typed fields for IPC namespace sysctls
>   sysctl: use typed fields for ucount limits

Gentle reminder about the patchset.

>  fs/proc/inode.c        |   2 +-
>  fs/proc/internal.h     |   2 +-
>  fs/proc/proc_sysctl.c  | 681 +++++++++++++++++++++++++++++------------
>  include/linux/sysctl.h | 138 ++++++++-
>  ipc/ipc_sysctl.c       | 189 +++++-------
>  ipc/mq_sysctl.c        | 104 +++----
>  kernel/ucount.c        |  64 ++--
>  7 files changed, 772 insertions(+), 408 deletions(-)
> 
> 
> base-commit: 587858367581b9c55c3690f4e63382ad622719d4
> -- 
> 2.55.0
> 

-- 
Rgrds, legion


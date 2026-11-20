Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795194602;
	b=Azot1MvWh0ph7OSH4BQFSAcL5lfb03bfjVSRzMrvC6ogzV0Ihhsn6+yxZPEJQyySATFM
	 T0v5bpHMAEFBrdmKNricxHerG3WlzTZ2G4Z2J0yQuKvj5hUHutX4zoV3ieyMYFtpD18a+
	 M/3fPsjbPtZLky5gZ11OPcBcYfHjYjXkHR8tGvD1/re2zrlVl6pgjIsFOEewf4fqyDoW2
	 imRVaXi5iiaVE2WlF4lGIh7O013GZBLn2cF2J8iS8oF09pyNofi2cH2mIGXS5juKLs4Yl
	 qxYRUSTPRI2u6GFFjIby61OpT2ia3FDCDt05MPA9ZI5C0DUsJLZ65b5CbgMUQ+a6khg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZjKXRhmMlyIf4k/Bgeh6+i9VHnnHMzl/5R3cKodeiFA=;
	b=EbKPoXetUpAJ7lu+ULxd6vh3hgLzaezp4Q5FgPzarbLu3fd/VlsmbTb1XNUU+Ozb7zdY
	 8H2BUBLqd/7qwgsflR1oxs7RDE8hwau54LFAgsmVBMXzXZ//TBCnW545vyu+pV81lmYri
	 F3XYifQjeMuUOlpic+N//fBLY3bPkZs2/LYYadSoYJ5K2GvH8IDDFeE2ujSo3ruv81atv
	 mTmfjW1dnqQ4+r6oESulsX8LeB0jY5KiRd9nCfjrXW+eMm+7qMwtFslStldrLNe8NZe5n
	 4jDab1orOJeMSn0FMjgWRNwZRFTnQRZ210mWmx5ZieSotjjuDlvNyMMEv4BcJE0/BOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KzuPKz9w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C717606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 17:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C717606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KzuPKz9w
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c1479be604so806361e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 09:10:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795194599; cv=none;
        d=google.com; s=arc-20260327;
        b=insls4KiRVfbsUmQuHe+YSE6Whl2rTLftsh5hsbUaIbueo5fL6D2h3bcJ+uzvpVMyD
         UyVOjdG6G6IJ3IwnN6lOKIsaGTfoz5tFf6V2sfWNeTi9lK3gOvW0QGiijxXSelKxlVVP
         +YHFML8iUltNx5hLfVxzUQqG6DfpAGlUOiJJtuiSBOy8qxIYqUakUjV7ZX4p2h7fjIhT
         IZZF+tzLusMMP6V/MqKRyz4inxihKGLmwnXK746i4rUxtCl7HWXJ4P13l2jVAzOtFc5S
         SBzQMvlwbyRYCY74DOa97D/O8Nr2ILzbJiyZrzgGHDF5OYFXm22dSG/QSeUEaKeC4ynN
         kAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZjKXRhmMlyIf4k/Bgeh6+i9VHnnHMzl/5R3cKodeiFA=;
        fh=6xajy8dZAmLqe/NIscQJ2stvMXyrzcumgt+Sy/bj1pE=;
        b=bCk1zYr7lOUFYk2qnb2WLZBkCjFHgW67u0Rfgl3Q4kRM7iuYY/mke2qS8/LyMkTJ6B
         3I6sMXnIQ6WxSr3U8VqZ9Dq2PmA7IlVa9y3k9sC/xzj/kloO2aJuweJtOJccVUauhDBI
         nXvy5DTNRjvF2HLMsSLjB1Bxpjkn56f7Q8+QsqACLXc4H8mO91koBrTRkiMRReMcPFBb
         ULAPRFprxPh+er55oXiW9TXBWE1oh6xuXGJQIpjOq/bw/l3q8+fOmcFhJvDqS4XI4Pq3
         CLs2b22upvGA4q7kJ1wYW79KrVXKb+Y5NdnMUWkZgq+AM2wiMiA1dWPvsKqnKFagCP43
         fxkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795194599; x=1795799399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZjKXRhmMlyIf4k/Bgeh6+i9VHnnHMzl/5R3cKodeiFA=;
        b=KzuPKz9wlUIhaJWdwueDeEluQfGhTtFH6fz8FAZF85dKlUnHi8FkaBQALudYSWmLoT
         azKe3eFVYRDOFx+8IjhGNb9qwSrA+uMjFasO0Y78bF+3hajdbSeasLRKTqR9rrRw93Fs
         mgsw5HsHH8a8RLldzj7UExTUzudAO7FPQcBGxVHr544OLOOoquGgLjJUclHerWxaJdLi
         uxmk8NZd0Ky9WVaupdZUPVmFOhf9Zb4PrRXYdyH2vDYOnjm+WhZ7uYiyPgxh2C1qaltX
         V7aCX88km55ADvHdXfnZgPboy0v8Geo0MFUxnSN4Wp1aITRMGG9KONQZYt3Rs95J370H
         rqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795194599; x=1795799399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjKXRhmMlyIf4k/Bgeh6+i9VHnnHMzl/5R3cKodeiFA=;
        b=XQUPEhH6ycSPs/E8BxIQ7T/7JvLkGhBxsDeNXwHNM50KSj/0tNeXNHcn6w4YjqmEzg
         +M/DlJ/E7l3f7F9r4y784HDPztiQC7f4b8TnuAfffatkjHt2hcO3siFiqQo65pDPteAc
         V2oivBRQpDyy0tthE2wltSOcr+S7wyo4GyxgkPvSqAWXSGq+R7w3Nnj1AN1026zP1943
         CbCFbq9re6S8X3A+jRlrQQzGoYTZVWxV1Dz/ipKn9Eg9964H5ibaebGZpQPkzn9yS73x
         3idxL53baKqFBV8t1Nlrmdr0I6bSHoCcVookbRuXcUMyZ3GVYoxX3IrffH7RKxuaHSyP
         2wHA==
X-Forwarded-Encrypted: i=1; AL+hErGs1baP/w+RGmM0Raz6EHIVSe5KoDxSCLVqVjnkEyIJaG3Y//7cMJ67ZL3u4H2l0XtFDVNzHbcGFg119ajB@vger.kernel.org
X-Gm-Message-State: APuU4Z98T+LDksVdB5dMWQba1O4hZKWUCy5GZa5YRFFrSpkipnFeLgUY
	mvO6Ku4AiMGi6lnAdKzLSDw3TLG3ri40nPNpmo4QxNSzHDCfigDHkqA0jc9i1wqO7/Cx+PhJw3i
	kOtktpbVLiS8doZaVYv7nYYXVL/Xt0kCJ7XlB7DNf
X-Gm-Gg: AZFdTZcRRzJO0spCI3/GPpJnq/DDMFYUq/PYMlaInEO+EjUjOgrNYjpz8HjcXA/B2UT
	O4SKDorrH3Crf7K91rMO2clPDxcwfvyHX0jP+adyxZJSWzTEf/v9KMTJxOjh3wuER7ugjLZkPqQ
	gRsUegfTQP5MnZIuULHq12n2NKycWIDJI3hzkDwchMrAdc/fYnSKQl/G8TI7MNOMUWRO6fzRGaz
	NOcG398xL+hTA2B00d6eq0xtebFMhOPadOgBqrF4mOoVZ2tESlJy87OVMSXQ5VEbbaBf6Uysf80
	e9vGZb4rhAMG/9kcVJGALwX7zuaTSdlwqw0YN24jzDkHmx/rG1KHi1/bmOrQd8WUW7kapRPOfzr
	kKMjUXDTFXrhVoTCuAc898dFs/oB+l25B/w==
X-Received: by 2002:a05:6512:1042:b0:5c1:4c4a:f026 with SMTP id
 2adb3069b0e04-5c1bc6f633dmr1312524e87.4.1795194599155; Fri, 20 Nov 2026
 09:09:59 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119104208.782900-1-halg@google.com> <20261119104208.782900-2-halg@google.com>
 <CALCETrVqc+1bjH1bhqHee9bsUdk2B6314z7PMexbsnNpMhk14g@mail.gmail.com>
In-Reply-To: <CALCETrVqc+1bjH1bhqHee9bsUdk2B6314z7PMexbsnNpMhk14g@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 20 Nov 2026 09:09:47 -0800
X-Gm-Features: Aa3M54qqiWJmEKSjiAInchWSC43ADdXnD64UgkMS8cTjGJqVilvL89j5dcH7YsU
Message-ID: <CALCETrV=zSxb6sgA08DLiK2bQovdMEj9ycG=Cc71mLn2C5Pgeg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] userns: introduce capability bounding set for user namespaces
To: Andy Lutomirski <luto@kernel.org>
Cc: "Hallgrimur H. Gunnarsson" <halg@google.com>, Christian Brauner <brauner@kernel.org>, 
	Serge Hallyn <sergeh@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jonathan Calmels <jcalmels@3xx0.net>, Jann Horn <jannh@google.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Singh KP <kpsingh@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-api@vger.kernel.org, containers@lists.linux.dev, 
	keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Nov 19, 2026, at 2:52=E2=80=AFPM, Andy Lutomirski <luto@kernel.org> wr=
ote:
> =EF=BB=BFOn Thu, Nov 19, 2026 at 2:43=E2=80=AFAM Hallgrimur H. Gunnarsson
> <halg@google.com> wrote:
>>
>> When a process creates a new user namespace, it receives a full set of
>> capabilities (CAP_FULL_SET) scoped to that namespace. While namespaced
>> in scope, several of these capabilities (such as CAP_NET_ADMIN and
>> CAP_NET_RAW) expose broad kernel attack surface that many sandboxes and
>> containers never need. However, there is currently no configurable way
>> to withhold such capabilities from user namespaces while still granting
>> them to workloads that require them.
>
>
> One thought (from the rootns thread): the other decent sized attack
> surface here is CAP_MOUNT_ADMIN.  Which doesn't exist as a capability
> bit.
>
> A sort of horrible solution (but maybe not so awful) would be to
> declare that the bits in cap_userns aren't actually capability bits,
> and that you need the bit in cap_userns *and* the bit in cap_effective
> to do sensitive things, and that mounting needs cap_userns to have
> NSCAP_MOUNT_ADMIN *and* cap_effective to have CAP_SYS_ADMIN.
>
> I want to sleep on this.  It might actually solve several problems,
> e.g. controlling creation of ipv4 and ipv6 loopback or tunnel devices
> or whatever.

I slept on it. Here=E2=80=99s a counterproposal.  I=E2=80=99m not saying I =
think this
is better than this patch set, but I think it=E2=80=99s worth weighting the
options.

Define a whole new set of privilege bits.  As a
poorly-painted-bikeshed option, I=E2=80=99ll call them eprivs (for exposure
privileges - it=E2=80=99s a crappy name but at least it=E2=80=99s pronounce=
able).

An epriv is not permission to do something *to* an object; it=E2=80=99s
permission to do something that exposes a meaningful attack surface
within the kernel. So there=E2=80=99s no ns_has_epriv because there is no
object.  These are kind of the opposite of object capabilities.
Additionally, an epriv never grants the ability to do something that
one couldn=E2=80=99t do in an epriv-less world.

For now, all tasks have all eprivs, even not-yet-defined ones, unless
user code or config explicitly changes this.  (Maybe some day secure
boot might remove certain eprivs.)

There should never be a check like ns_capable || has_epriv. It=E2=80=99s al=
so
&&, or perhaps caps are not checked at all.

Example eprivs include:

EPRIV_FSOPEN_VIRT: may fsconfig, fsopen, etc a virtual fs like fuse or
tmpfs or overlayfs.

EPRIV_CLONE_TREE: may clone a mount tree

EPRIV_MOVE_MOUNT: may move mounts around (but only if you also have
CAP_SYS_ADMIN on the correct namespace, of course)

EPRIV_FIREWALL_TC: may configure any firewalling configuration or tc
configuration (this includes iptables, nftables, and ebtables)

EPRIV_NET_RAW: may use raw/packet sockets (like CAP_NET_RAW)

EPRIV_TUNTAP: may create and attach to tun/tap interfaces

EPRIV_IP_LOOPBACK: may set up IPv4 and IPv6 loopback using whatever
new facility we add

EPRIV_NETLINK: may use netlink at all

EPRIV_NET_ADMIN: may use traditional CAP_NET_ADMIN abilities (all
CAP_NET_ADMIN checks will also check EPRIV_NET_ADMIN)

EPRIV_OPEN_FILE_HANDLE: May use open_by_handle_at, etc.

EPRIV_UNSHARE_USERNS: may unshare userns

EPRIV_UNSHARE_NONUSERNS: may unshare any other namespace

EPRIV_MOUNT_CGROUPv1, EPRIV_MOUNT_CGROUPv2: may create a new mount of
these subsystems

EPRIV_PTRACE: there are lots of different variations that might make sense.

EPRIV_MOUNT_PROC_PIDONLY: may mount proc-pidonly

EPRIV_MOUNT_PROC_NOTPIDONLY: may mount proc not-pidonly

EPRIV_MOUNT_SYSFS: may mount sysfs

Example eprivs that are questionable:

EPRIV_DMESG: the kernel log is a specific object, and I think it's
better to control access using something kernel-log-specific.



There is no operation that increases eprivs -- even without
no_new_privs set, a task will never gain an epriv, nor will a child
ever have an epriv that its creator did not have at the time the child
was created.

The evolution rules could be as simple as, on fork/clone, the child
inheriting exactly the parent's eprivs.

Or we could bind eprivs to a userns instead of a task, but that could
be more limiting and awkward than we want.


What do you all think?


FWIW, I had an LLM make an inventory (surely not exhaustive) of
recent-ish CVEs and how they relate to this list.  (The below is the
only part of this email that is LLM-generated, although I added
EPRIV_SYSFS because I didn't realize that nonroot userns could mount
it until I asked an LLM, sigh.)  To me, the list and its breakdown
suggests that there is quite a lot of room for meaningful attack
surface reductions while still leaving large parts of userns
available, and that my epriv proposal captures much of this but the
cap_userns proposal may be too coarse-grained.

(I also asked about eBPF, and my LLM came up with a lot of CVEs, but
there's an existing BPF token mechanism and I therefore did not
propose EPRIV_LOAD_EBPF.)

--- begin LLM output ---

**EPRIV_FSOPEN_VIRT:** CVE-2022-0185*, CVE-2023-0386*, CVE-2023-2640*,
CVE-2023-32629*, CVE-2025-38499*

**EPRIV_CLONE_TREE:** CVE-2025-38499* (only if the check also covers
the relevant internal mount-cloning path; explicit `open_tree()`
restrictions alone are insufficient)

**EPRIV_MOVE_MOUNT:** CVE-2025-37988

**EPRIV_FIREWALL_TC:** CVE-2022-25636, CVE-2022-1015, CVE-2022-1016,
CVE-2022-32250, CVE-2022-34918, CVE-2022-48911*, CVE-2022-2588,
CVE-2023-32233, CVE-2023-35001, CVE-2023-4004, CVE-2023-4015,
CVE-2023-4244, CVE-2023-5197, CVE-2023-6817, CVE-2023-3609,
CVE-2023-4623, CVE-2023-4921, CVE-2024-1086, CVE-2024-0607,
CVE-2024-27397, CVE-2024-26925, CVE-2025-38001, CVE-2026-23111

**EPRIV_NET_RAW:** None identified.

**EPRIV_TUNTAP:** None identified as requiring TUN/TAP. Some
packet-triggered exploits may optionally use it, but that does not
establish it as a necessary blocker.

**EPRIV_IP_LOOPBACK:** None identified.

**EPRIV_NETLINK:** Also those blocked by `EPRIV_FIREWALL_TC`, insofar
as the documented attack paths use netlink. No additional CVEs
identified.

**EPRIV_NET_ADMIN:** Also those blocked by `EPRIV_FIREWALL_TC`,
insofar as the vulnerable operations require `CAP_NET_ADMIN`. No
additional CVEs identified.

**EPRIV_OPEN_FILE_HANDLE:** CVE-2025-38306*

**EPRIV_UNSHARE_USERNS:** Also those blocked by `EPRIV_FSOPEN_VIRT`,
`EPRIV_MOVE_MOUNT`, `EPRIV_FIREWALL_TC`, `EPRIV_OPEN_FILE_HANDLE`,
`EPRIV_MOUNT_CGROUPv1`, and `EPRIV_MOUNT_SYSFS`, plus CVE-2025-38058*.
More generally, blocks the documented unprivileged user-namespace
setup for the entire inventory when no usable user namespace already
exists.

**EPRIV_UNSHARE_NONUSERNS:** Also the namespace-dependent attack paths
blocked by `EPRIV_FIREWALL_TC`, `EPRIV_MOVE_MOUNT`,
`EPRIV_MOUNT_CGROUPv1`, `EPRIV_MOUNT_SYSFS`, and many of those blocked
by `EPRIV_FSOPEN_VIRT`. Coverage depends on whether the necessary
non-user namespaces already exist.

**EPRIV_MOUNT_CGROUPv1:** CVE-2022-0492*

**EPRIV_MOUNT_CGROUPv2:** None identified.

**EPRIV_PTRACE:** None identified.

**EPRIV_LOAD_EBPF:** None identified.

**EPRIV_MOUNT_PROC_PIDONLY:** None identified.

**EPRIV_MOUNT_PROC_NOTPIDONLY:** None identified.

**EPRIV_MOUNT_SYSFS:** CVE-2025-22089*

CVEs not cleanly blocked by an operation-specific bit
Excluding the two EPRIV_UNSHARE_* gates:

- CVE-2025-38058: No explicit unmount privilege. The vulnerable race
involves umount(2) and path lookup.

- CVE-2022-0492: The cgroup-v1 mount bit covers the documented
new-mount attack path, but not necessarily configuration of
release_agent on an existing writable hierarchy.

- CVE-2025-38499: The correct gate depends on which filesystem-context
or internal cloning operation reaches clone_private_mnt(). I would not
count EPRIV_CLONE_TREE as a definitive blocker without checking the
exact call paths.

Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48F73CD8A6
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738521; cv=pass; b=A3e02SDcGJSuGUgGU5ItCzGscvCYkSIqedZoQPwLT0O4xKeb0nOYRq6YsLGyk1jQfciYJrYu1yMgWByzaV9qEyOAc9I9Rt4zObGFAiGwV7KsKf9IL4KiRhwkRbrvYtsCOZJ5ULPbQYhMcfOUw987RN5alnFWeo/GeKGjw1QmVa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738521; c=relaxed/simple;
	bh=CXVexyaHWcToRDmha3nkO9tNbAoOtfc3VkC6kJvbNfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6Bs+hLdqcgoDNt6kvKJH8gIcpUroFAUbzdTJpqWfaM8KkfvrrNLNiJYFX4eNpuuVSe4CMzKf/Glya+Re62i+p11Jk/X9RH7ab8IQ+TYSG46oxeErlw3sG0uH5RtVx46LuBO3+bDqp50EQhNbt3TBAUsP3lyNhA4vBN0QI8NaUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IthU/XcS; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IthU/XcS"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9b1ffbb9f5so120961666b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 05:41:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775738518; cv=none;
        d=google.com; s=arc-20240605;
        b=V3wFqCuKrFhU99NEOCquKxDWqsDIi/K/9ysCWKe7snh0GvpjhfbjirMt1yzWHtJ52w
         ATJIhacU7FYzQ6orhrt2nz1eFZvt2A5/8J5/8nvbOH8qwo4y805K5C1af4lHCvShbCzX
         ldZlud/klbI87BfeenXox79rEZ3Ga9zgiwTKoQ+bprKAw0f6rtB1AaxTe8HsVseadalQ
         CVG/NJY3VNOgfN0SpX9UQEB0a9gmph18iNNXeoA2GWGVm1QyELPkQg358gIEkaRVUnTX
         bxEMUNDvkfuGv3BF8M5Eh/A0SJU0xQukIsAfpPoQtTYlwsu/ueiR7VI81wJKrs0Jg4q5
         Wjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=krEW4g39zA5lK72ctRH8tMRv6A/4JdJgscNdgkiGL6s=;
        fh=0e842PpyFJc1eA+vrzEyaRgz2A/n2XFY/uDNoztxWkI=;
        b=Z6Vcvfx3kBLA/d8tW6VlQI5oWWWB/VSIJ6uWhlm3raxAZ//4kCzcXqsKxW57VJyMVL
         tYBNVNPEQ7Rg4nU6Zx9wS56eGuEqlC0tss/1VFnSxnGEoPImYz/kDhG7W0UuDS/p1LVj
         yzdamCMdW15g2V2ZdzVF9y1pFp5to3yd31Z5SA/PNhupVhOXzr5yUyo3zjkAZhU4jnt7
         BU++vixLPj6kdFuNehto0KSQzDmlhSLRlJ3N/2SwDJNwJ5JGJpJ0qcwlrp3G26HptPxB
         dcFzm9DubsBYdRvRs13W8y7cn5jrebVHT/bQCzlPkhtTErTFufIMMKf2W2L0pOIN4L98
         KdKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775738518; x=1776343318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krEW4g39zA5lK72ctRH8tMRv6A/4JdJgscNdgkiGL6s=;
        b=IthU/XcSupH+OgHD8NXunweaKIvTONcJamSFL5u6YyWy40cjdTPM6ugARishw4pYUp
         Dw89NmnKassrmOiY2qq5pmJwgLzelNf3qNP+x67owH3luLUT/9QOLpq4DGf7LwpcCfl7
         1TSF0U1RizNxdjbzhsH1GK0suw4xx2nLOMnsgBMufgGPf6MrMnFwkRjEi1gT6Y0+aaR7
         exEWYybDlgDsaWqWEHVgyIc6ERSKoT7KbjiC5X5ur+Ub1rWJzMBsa6FVLLRejl68RAW0
         j/N6kiglSHfHGnfvpSouDjzl0DPyI1k5hJTQA5x9If6qKOFKCwRxj/0zliDTnx3qxsFc
         LGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775738518; x=1776343318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=krEW4g39zA5lK72ctRH8tMRv6A/4JdJgscNdgkiGL6s=;
        b=GAXiCAfFfK9ujOucB4WVgPhVNrxCAPgfWtG8pH9V3VsSDCHYw54r2/iVMnlp0rPIgX
         vZt+CWQr5EBzQPv7QdKdFaIFJ+ofGx+IoU2Kea3TLZPXgspJBnFhX3WDWolZUN4EZWE+
         QI2TGM/Em4db+HpNUrcbjSTTVuhjV+O5edht0GXgDjDakTATyRqAaviW3dcjqtDE3dZR
         qZqYGZe9+v5IDDVLq8kYDGGMnXHjjvDthsEC33Qwm+HJnh3qgb5RqbhE2M5d0I13a2yW
         7Hbgp8ZMKmZLE6s3HGbz099wnE0gzuYdZaCOPDie2UyKfIE0vXnWQPyx6ji46mvaP9wb
         tagQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/442L9061z2elpzpbe0hewNH9Z74r1VTqGN331TF/Q6O2i1WYAnASjAE//v45pI7f63RixIFSOxnuk33s@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzhtf93aYcUmubZzTPfoC3DhKXTEHhc3bY5/IgIbTEpjFmDwGe
	thXZ5EsaSkE1P+l7IN9qhCuBUhw78dZUGluat9ji3rk7G24hFU8QePYZlwWeE+YZvPSTYxuXUD6
	ocAbYAzzhNK8Q0l6IWFNpbr0GGUs+2s6m67H2kSk=
X-Gm-Gg: AeBDievBD4B8gis+0rzDp5MQulWRdQgc5r3U0LQg/G/ru+5vtBk1zlUItUnXezMhPBi
	8pv9vxJX0FJpgo1ss/oqsn4fUx+N7vcGu1hZlc5WaI5eSipZSy/m5yqtD+MVRD55V181KB+4+Kx
	RwuP0HoiyEska0m1Jp7Wf+CxF1t9PicMhFtkIqdFFyirJm81FI5iPwwhoee+f8gnNsc7uaxRrtR
	dNCFsMTkODXgoa4DWwtR7V6SOZvz+tg3Sd33j/QEivQFatZyNpMxZXJEjj11zk5WRYMTob9hPrV
	Uuk/YwiKir4iDFioTfF8IU83cGqu9BUxPmeM6/gak/gyybFUpqIx
X-Received: by 2002:a17:907:2d9f:b0:b9c:b3b5:bbf0 with SMTP id
 a640c23a62f3a-b9cb3b5bc8fmr945171466b.6.1775738517415; Thu, 09 Apr 2026
 05:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DGJLR6FR7XLX.1D72IEB0DX9KC@wdc.com>
In-Reply-To: <DGJLR6FR7XLX.1D72IEB0DX9KC@wdc.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 Apr 2026 14:41:46 +0200
X-Gm-Features: AQROBzAuccbaZp02NzvMuXculSFeovu_NcZCmib9V_mWpNftbSe0wxj4pImE1J8
Message-ID: <CAOQ4uxgxUAzmmS7=TJi2zDX15vkG7Z2jtG2_Nh=HqEeyNLzzXw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] eBPF-driven Data Placement Hint
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 8:22=E2=80=AFAM Naohiro Aota via Lsf-pc
<lsf-pc@lists.linux-foundation.org> wrote:
>
> Hi all,
>
> In Zoned Block Devices (ZBD), Garbage Collection (GC) efficiency is the
> primary determinant of sustained write performance. While current ZBD-awa=
re
> filesystems (F2FS, Btrfs, XFS) are zone-literate, they typically fill zon=
es
> "blindly" by appending incoming data as it arrives. When "hot" (frequentl=
y
> updated) and "cold" (static) data are interleaved within the same zone, t=
he
> filesystem must move the cold data to a new zone before the current one c=
an
> be reclaimed. This write amplification leads to significant performance
> drops across the storage stack.
>
> Existing solutions for data temperature segregation are often static (e.g=
.,
> F2FS file extensions). However, these don't scale well for dynamic,
> multi-tenant environments where data lifetime is better predicted by
> application context or directory hierarchy.
>
> We propose a unified VFS-level eBPF interface that allows for flexible,
> programmatic data steering. By invoking a BPF program (e.g., at file_open=
),
> the system can set necessary steering information, based on parent
> directory, process, or custom metadata, to ensure data is directed to a
> desired zone or block group.
>
> # Use Cases:
>
> - ZBD GC Efficiency: Programmatically separating short-lived journals and
>   write-ahead logs (WAL) from colder database workloads into distinct zon=
e
>   pools, enabling clean zone resets.
>
> - Multi-Tenant Isolation: Using cgroup context to influence e.g, block
>   group selection in ext4, preventing "noisy neighbor" fragmentation.
>
> - HDD Performance Zoning: Steering latency-critical metadata to
>   high-performance areas of the drive while pushing archive data to
>   lower-tier zones, accounting for hardware-specific geometry.
>
> - Optional: Transparent Compression Hints: Expanding the interface to ski=
p
>   compression for already-encrypted/compressed formats or choosing betwee=
n
>   LZ4 and Zstd based on workload priority.
>
> # Discussion Points:
>
> - The Attachment Point: We currently use a struct_ops approach in XFS, bu=
t
>   a cleaner VFS-level path would be allowing bpf_prog_attach on a directo=
ry
>   FD.
>
>   Discussion: Is a new hook in struct file_operations the right way to
>   "pin" a policy to a subtree? Are there better alternatives?
>
> - The Placement "Contract": Defining a stable struct bpf_placement_hint
>   that works across XFS, Btrfs, F2FS, and ext4:
>
> struct bpf_placement_hint {
>     enum rw_hint i_write_hint;
>     u32 stream_id;      /* Generic Stream/Class ID / Block Group hint */
>     u64 flags;          /* Behavioral toggles (e.g., ALLOC_FROM_HEAD, NO_=
COMPRESS) */
>     u64 private_data;   /* FS-specific context, could have compression hi=
nt here? */
> };
>
> - Lifecycle and Persistence: BPF programs are runtime-only.
>
>   Discussion: Should we keep this as an FD-based, runtime-only attachment=
,
>   or is there a need for persistence (e.g., via xattr)?
>
> I look forward to hearing your thoughts.

Naohiro,

I scheduled your session for FS+IO.
You did not mention if you needed the BFP developers to attend this session=
.
I assume you do not?

Thanks,
Amir.

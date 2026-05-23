Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1139A7F9
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779544747; cv=none; b=IUtHyAi4lWZTn7ugrgmPNCE39PUDpGrd/S5t62e+V5yvim9YyMbYjDALDbi7dFamJLO1TDb143CqJONlULNABjc4hZTpzg7hVP/npEajaGCDtkYiH31Apdjc+4Cif0fmbpoQswMggvv0SZWRIXxXbqrLQzpeatcfGY5zlJV6Ero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779544747; c=relaxed/simple;
	bh=TRlkh5uSVY6VnHdPQSRiBM4K09lH8L0nypdvwRDatkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMXxLUmLyXgFtDUgj+hBcr6gij0kS/zW/QeJE5YQCmpzQmHbgoQkYBZDCdBPB8O6MQgHUmLDjfqR6liQbBFV2ZQeima2QbAAIjvV7li4irRxpdXTfC0KFf8Hu8EDtbFJzS55RHA1n9jrNKEdhwhlr4RWujHzbMp0ha8BDS/PsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk8SLCpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk8SLCpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BD21F00A3C
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779544746;
	bh=TRlkh5uSVY6VnHdPQSRiBM4K09lH8L0nypdvwRDatkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Mk8SLCpvtz4ynktlkYx3ukqir4sONSIBmCf8FMqt1Gtet1hY/FR+N+A5XV8nOshxq
	 j28J5Pux2d7Zi02MRReX5jzADGcOBlhnsqJZBIAAcH3n//93zuXzcHyyQaluCVoEED
	 Lr0zrnChNwMGV7siYcgakv4n5iENYrR7NMeqvm5Sp9Xkv9/JaUvLH3RwlDWos861u5
	 igsAUmwcNtwMxBSmmXkwY1xtJdFiFVEf+K3XQqrlvVNY9bRmb3vinXmoXhYMe7l1H8
	 v20+DY9lVdbGELuBa0uFAg6lJGcXETJ7nXcWgzaG3FfiQokmbm+u9/9xsK7lTMNhPX
	 8w1l+vZw+tMEg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-687e7edaafeso1983615a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 06:59:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9g+TIDFL7GmI0MTJ45xYOhza2Hg9YzfMCxbMxFWVh0x1CxCnEm2NRFEurs/e+rR8SpcbAYjOKIpl8liu31@vger.kernel.org
X-Gm-Message-State: AOJu0YyQTaeInoA2M2WiQcz51ezxgLhpqdDfWhD2S/P3WNBftRSmQLca
	TmpHOdCPcdbsvh2kNqEzcAczXw0U91UVhuePhvnMOc7H4LDjb9yckN9nQlSjfTP/hw7hlBRMX/K
	g1IZBFuS6El38t2rwFYiFU7w9+ahzW/4=
X-Received: by 2002:a05:6402:458e:b0:683:f485:c63c with SMTP id
 4fb4d7f45d1cf-6889c4321c4mr3926209a12.1.1779544744900; Sat, 23 May 2026
 06:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522142048.1666937-1-charsyam@gmail.com>
In-Reply-To: <20260522142048.1666937-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 23 May 2026 22:58:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8kN27RN9GS3-9VeTSeqON2A94yYDksOUf0JmR=s6KhHw@mail.gmail.com>
X-Gm-Features: AVHnY4Ks6hsRZheM7VZDWBcqy-hkRWbCz9uX63PceZ3Aji4T2w_i1MzyP6TLtz4
Message-ID: <CAKYAXd8kN27RN9GS3-9VeTSeqON2A94yYDksOUf0JmR=s6KhHw@mail.gmail.com>
Subject: Re: [PATCH v4] ntfs: avoid heap allocation for free-cluster readahead state
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:20=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com>=
 wrote:
>
> get_nr_free_clusters() allocates a temporary file_ra_state before it
> publishes the precomputed free cluster count, sets NVolFreeClusterKnown()=
,
> and wakes vol->free_waitq. If that allocation fails, the worker returns
> without setting the flag or waking waiters, so callers waiting for the fr=
ee
> count can block indefinitely.
>
> The readahead state is only used synchronously while scanning the bitmap.
> Keep it on the stack and pass it by address to the readahead helper. This
> eliminates the early allocation failure path instead of adding a special
> case that publishes a conservative count and wakes the waitqueue.
> Zero-initialize the on-stack state because file_ra_state_init() only sets
> ra_pages and prev_pos.
>
> Apply the same treatment to __get_nr_free_mft_records(), which scans the
> MFT bitmap with the same short-lived readahead state.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next.
Thanks!

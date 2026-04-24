Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE938AC7C
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023798; cv=none; b=WA7VtVutqINJ/kCrf6UaJ/4SYLW980hanosD2VSUCS7RAdDELS+cCwYBoYDje+K9DhCi4V4KlCPuvRnN8Er2lYKVD5F9iq94VJSNt/mLwb1EuUlRV7YjoBrwDSSKUBk+cdV0DtGYhwP7avICjNyY3QIGagfZaC/xg+931gCdWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023798; c=relaxed/simple;
	bh=MrcSnLe6Ux6kcQj5f0tMveq8oHzcASzmk4IJBHN189M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=b9J4kO3OGHzshcDOTGWsCDuDybylSCpMJX5XFeUnkkj7yuP99PbciECGab0x2Jn+FlMLzvzZDv3WeWvBmI71RY6bKlG+l1GrKysRHRjAb9DsB+9aAIwKQUb8TL+/Z6tQhoICgclVFJUSyfZD4B86UW1kob8CmfFj9pC7YWVwz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU5p0iv8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU5p0iv8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so8641921a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777023797; x=1777628597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uqmyrQ8gLBUo18xHMn5xEIDMtFyh4GdfcnRwtOqeI8=;
        b=aU5p0iv8JcVpNeRlFvao7Mgb6AzAHZYlXk82l2PKjhYEjpDBqKISoIjZwUUje6AkYl
         ZNZaUyNosMTYgSKtkdDfSW/dTBKeVMd/Q59w7apQHwFp1quVRfsX5HhTr+2HaZDsx83L
         VYgQ5d8oT59raLVXGL8BL2Kg1aJ5raspIWfoKmC7FznSMF4QZw6hGPJOj+op2DW4jvuU
         xknZdxl5tHLY5lhqQvrmkl+4S1WgnoiGCVOxog8RK+QqAbt30RJ1hfAG6+3h6sJ94mTC
         BqsMZYHbAaLN2ZQmYFVG1R14Hkmb1nmtX5viZ0Cg9oxXiYeyrs5tjIrRSi9Z2mmHk0XC
         luaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777023797; x=1777628597;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9uqmyrQ8gLBUo18xHMn5xEIDMtFyh4GdfcnRwtOqeI8=;
        b=kKkGejOl9I2++6VE97RQhB6Lf+l8BALwQedLaKYYitR2Co8DlOv3pNj9V550KaKeyi
         lfi5ZAWZjIhttCGk4sttdUACQ4LZZryP+oGjIps1AODnWpvO4GDqH8rDgK6mR//+MIer
         ABCZ+p5M4GFFw7TnbwfywdrMwBEzFX1mcbynZFMD2J9c2MK0ARFizX8mhIoy1sxQC4HD
         yhYX1CtHHE3E54AEiO6GbG/tpAY439BTJWaR1VKawixHFcjZV/1LK5wX0BQ4oFbKrG0R
         90pmWaKp3641wK0dTqk+zB4wMeqQViefAW/CwgwhveJ5t8tdSUDk+h7xwRjKw1E/a5zH
         h2kQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rjH0+gR/TLG5Wn5OA62DX3InORRJVDVF93VIxHCO2eJcGU/Xi+4duM3ZBNSZZd6rSfY2YaH24vc/1QVRc@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBunioc5C1fOZG50ML86i/OVXsrASPvRFaPIH4Fj7/utcuAey
	ulh6GjWIzD35en8DieOz3OgjJE9yN9mfI0SWXNWXE1ni87ai9+FXlmNj
X-Gm-Gg: AeBDiev4PxByVfwNROwH/xSKpNmNv0DUUyRgmIFbD9Hfl7nD9wF4wrzV776R2cQXA0I
	UQLuMcyeiXJRxhpqjgEWrgcsSWxGm2UVR1aqHefxeFCJkZjYRo9kBNrHRk2oUZAOr05mhkZ28wn
	B96BEoejMtN9blddcGcw/lInT2Z+ybZb76w2HF7NczvGkxTkUbqKBboK0Vq2Kb8iDlrEItJ3O3r
	wtB0quhT6dKNJDcPGaCYijcimaRgUELhS9uM5rNrdVePjNoPiQAwU8qRLSUbv82n5rdANOl42da
	KkL4mpgz+QEudZfDJAgsdX8RztZC0YaY1mdjzLmDY5a9UJMb6tR6VFxHTWMmxnjRRA4Tml44siH
	aKuyp/NCLj/+sydAIwMbIKMtOuwvA1AXcxIyo5GPk2XRNqct4hod/ZBLFyela0iowmD0IpXV4Ky
	eXEqT+fqkDqC3tOFa1daTv/AuijUtEk6An
X-Received: by 2002:a17:90b:3909:b0:35e:3e86:e2d3 with SMTP id 98e67ed59e1d1-361403f12fcmr33224296a91.10.1777023796902;
        Fri, 24 Apr 2026 02:43:16 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20c4fsm274121025ad.59.2026.04.24.02.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 02:43:16 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, lsf-pc@lists.linux-foundation.org, Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Pankaj Raghav <pankaj.raghav@linux.dev>, Andres Freund <andres@anarazel.de>, djwong@kernel.org, john.g.garry@oracle.com, hch@lst.de, Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com, linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
In-Reply-To: <CAOQ4uxi0bTwj7oCWR1iOhqzPkB94cVgh=9Prh1kHxnObuLCz0g@mail.gmail.com>
Date: Fri, 24 Apr 2026 15:10:58 +0530
Message-ID: <tst0snkl.ritesh.list@gmail.com>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev> <wlxxrx10.ritesh.list@gmail.com> <aer0wd2Ig0hjN3R0@casper.infradead.org> <v7dhrmgc.ritesh.list@gmail.com> <CAOQ4uxi0bTwj7oCWR1iOhqzPkB94cVgh=9Prh1kHxnObuLCz0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Amir Goldstein <amir73il@gmail.com> writes:

> On Fri, Apr 24, 2026 at 7:07 AM Ritesh Harjani <ritesh.list@gmail.com> wrote:
>>
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>> > On Fri, Apr 24, 2026 at 06:32:03AM +0530, Ritesh Harjani wrote:
>> >> We were thinking if it is possible to extend the Buffered Atomic Write
>> >> session into two "continuous" halves of 30mins each (total of 60mins)?
>> >
>> > This is painful because you've requested me, plus both Storage and FS.
>> > FS has lots of space, but I don't, and Storage is also pretty full.
>>
>> I see, sorry about making your (and PC) life difficult here. I know it's
>> a lot of planning :(
>>
>> I think, both FS+IO folks will be interested to discuss both of these
>> topics. Do you think breaking this into two discontiguous session help
>> us plan better maybe? In case if we don't have any continuous slot, then
>> maybe we can split those into two.
>>
>
> I scheduled the two sessions as you requested 9:30-10:30
> for FS+IO and moved Parallel Writeback to Wednesday
> across the MM CXL session.
>

Thanks Amir. Yes, I think this will be very helpful.


>> >
>> > Do you need me for the full hour or just half of it?
>>
>> Although I understand buffered writethrough is an FS related area, but I
>> am sure a new writethrough I/O path is an overlap for you in page cache
>> as well :)  So, yes, it will be good to have your feedback on the second
>> part of this discussion which is - buffered write-through for buffered
>> atomic writes.
>>
>
> Matthew,
>
> I don't know why Parallel Writeback was scheduled as an MM session,
> but if you think it should include MM, could you move the CXL session
> to the now free MM slot on Monday 9:30, so that we can extend
> Parallel Writeback into MM?
>
> This will allow you to participate in the atomic buffered write sessions.
>

Thanks again!

-ritesh

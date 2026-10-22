Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684867;
	b=jSlUownU7VkKfAGqv+z4WssLYZMHpQZg8UK/nwyGI7PvOKZFeAnXEaEX0rguEyGHquDz
	 8bS2452kixOIU6DFDBYeSqv22zgU418UhLQ1L+ErQ7dXxsDtCMECLGVV7mnq/lkKQ6wiR
	 IKk/Rr3O6C2GwpQ3kkTT7u4SZX4Dfe7MJReM91GcWLF2Nf6reTBScmWhRpa6fyasbGcXH
	 SG7BL7qa9mfwzUI/KC/TMpX/+zW6qUkvZAVVR8Ml5BEaEAiu6WS/wyClZLyx1ZNdR81rO
	 e5yGU1/CNlTgt7NC6eRqf/mM9oOLkToWcMb3jZLd0nrhdlWcqFy4ts5iXAoYeJaVkVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=eHHz19nOUlPLFRSL+CDhh91ENP/dHGkHNHTFaFg4hGw=;
	b=Qswm7stjGZfCaMeIaeb1geQQn10Vhv0Z55lIa3RxnKIPpWso1gO+MSgDa1cLCs2tQOSr
	 9SaCiMRaCCgQkeWK0ApvEodOYUTXe25SR96NAeiiQvQHRXvAJkUSZ+dOqpoduy7O2XUmN
	 HIwGwrGzBlv6RI/ltrEHKXemxBLUl+3dUUIZv2inII8B4gunVFyJN2wAPQ3PYedHYV01g
	 bpTdvRBguK4vJid+DTUl5sOq5xSWEHiK6cz3l2pzdUH3mdlrfdTjUdPhcI7agxgJ6BOg8
	 6lHKlDTkv2O2GKm2MUytHQQRAIAgCt0wfIJGlBEZjomylAzr/w7jQMxD5LmfNwWujQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="o/C8w0X1";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D7606A319
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 16:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 237D7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o/C8w0X1
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36681e85e87so4247658eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684866; x=1793289666; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eHHz19nOUlPLFRSL+CDhh91ENP/dHGkHNHTFaFg4hGw=;
        b=o/C8w0X1JFCJCzsj9wqiMzBbf1HKiACo68tON325Bb5TJCx5AIRudOeR7R2v4ZO60f
         gfgLUs65dWsklkvOCDmB97l7NGM75lpDcj0tJP7t0Jw1r65nOTExKzyu0UuR+W/RWR0a
         /dXtzIqyPcJP9gmZgmRh6+6Xv0AAzlF7+CkBtVbF3ARCjet7gpCvueRIK3hjA/KdsnRa
         i+UF7+O9TrCwDTA2tTxCo6wuz3TNPqOE4r5cUkkSX0ym8d6Zr3OgPd2gWPmVsR93qURd
         3fyan+yckODDxP3JD9CqPzBZomT1rpbgLe6Nxtd55ln0tHsZW1fo63V2HoO4ZptuPVzV
         6qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684866; x=1793289666;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHHz19nOUlPLFRSL+CDhh91ENP/dHGkHNHTFaFg4hGw=;
        b=ElkOBwyS8SdWAjyvDvZKILaoYRCIpyFf/qRHwftH3m5+PhTvFkPZuNeck0yGwnm6VG
         YcDcKdRO4xNJZadgQN/m8NU02uqNGduiXikXdbTK35M87Euf5kUJ4WBoiD/ivI0fHfIA
         LEZqcg/gVMGCpTsyO+vY+TFJmNPz9wGZ1GYRheut8iS8A6PEllwIzYQv6rxeUS+kAjYg
         KJYxon2fk3m9SNvM9x8AusF41O25sq3em5qanTSI/+bJwqaeoXqH7iFGetFVsVhcE1pI
         v3Vhl3eTorcT3g7lG9neBZPIegKrjQrPIAOGyN0rBYCN2xpdm4vfVHjgu7Gm9mmv0gYY
         7TbA==
X-Forwarded-Encrypted: i=1; AKwUvByT6+t0pNy1+dcqADS1j6yx14i+ZrzLkHJwFgSB/z9YUI3J79pi6aLURHidmIQaUWxRZeevLoS3D5dx0hD8@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0NjW9V5qdxb7di9YIJoDJnBokk6f2z9+cbberZRo9fxyIAy1h
	8uCPKXcXo8wiwP853BqurOYm30DXGJ/RqRqh/Zl69J0jGM8BVW21rMfV
X-Gm-Gg: AYBFou19KbR0SO0l/6R3p3kxNyu5YN50tGn2Fm3Y/e2Uq8hiFPlIUMcu2Yg9uk4jhJI
	sV9yrVj7u8JETJa1gb1RotaqqD+fUZxoV5iwHBqraXTkzmeRfPoK0iOueIIk3rbj/NeNVP4mWs7
	gdMImfGmSW4zgNCXaNib+cQkhhZfnEWuEe2TBSzZYKQmC8BToa2kg7QK6G1ubUkuYf8xN+LULpE
	o6FJ9KQWz2AvtIfILxH0fZLdRzAyfCMN7HfClpyGd9CHeQjTl6VwJ08AAa5Re8vCdRo2jQ2hF4V
	/KGPylTgRbpgOLmFjjU29XB8wl6J5x8UwcLHj7ojHxC8T+7LKU9xqki4e+8hsi6EjKYQecv2Kbm
	K+nw1qRqigo0nMxvfLLGjjDie9H7TFpGjtVLr7YiI8RXavFBbW2yrah7o7FeBMRSP5H5/bfwfNB
	R2xISJ/s19TprEUs4XKBKW5nB8eiIjfe/8je1lwmilXcI3gwshNv05jUPhPWVfZ5TbQZ50DcTl7
	Qf5h67n8I0PD7qMVV0opu4BCthHehR+eQwQghQYW8aN44f/gbWBYRVJplY+AgzQqdzke/XGj9c0
	va1O
X-Received: by 2002:a05:7300:c019:10b0:366:83dd:46f3 with SMTP id 5a478bee46e88-3674de4cb85mr8534410eec.14.1792684864580;
        Thu, 22 Oct 2026 09:01:04 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1cdsm19744253eec.25.2026.10.22.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:01:03 -0700 (PDT)
Date: Thu, 22 Oct 2026 09:01:03 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Benjamin LaHaise <ben@communityfibre.ca>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] fs/aio: io_setup integer wrap can exhaust global aio quota
In-Reply-To: <20261022154852.GQ8374@kvack.org>
References: <20261022091748.3653127-1-teel4res@gmail.com>
 <20261022152305.GP8374@kvack.org>
 <179268384018.50580.15623131516982541149@gmail.com>
 <20261022154852.GQ8374@kvack.org>
Message-ID: <179268485745.64118.8307604514392982010@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ben,

Here is the exact path, step by step, with the values at each line of
v7.3 fs/aio.c (commit 08ab31164c55). Precondition: root has set
fs.aio-max-nr to 2147483649 (0x80000001); fs.aio-nr is 0.

The caller does io_setup(0x80000001, &ctx).

1. Line 796:  max_reqs = nr_events;
              max_reqs = 0x80000001

2. Line 807:  nr_events = max(nr_events, num_possible_cpus() * 4);
              nr_events = 0x80000001

3. Line 808:  nr_events *= 2;
              0x80000001 * 2 = 0x100000002, which does not fit in
              32 bits, so nr_events = 2

4. Line 811:  if (nr_events > 0x10000000U / sizeof(struct io_event))
              2 > 8388608 is false, so no return

5. Line 816:  if (!nr_events || max_reqs > aio_max_nr)
              nr_events is 2, and 0x80000001 > 0x80000001 is false,
              so no return

6. Line 845:  aio_setup_ring(ctx, nr_events)  with nr_events = 2
              succeeds and builds a one-page ring (127 slots)

7. Line 856:  if (aio_nr + ctx->max_reqs > aio_max_nr || ...)
              0 + 0x80000001 > 0x80000001 is false, so no error

8. Line 862:  aio_nr += ctx->max_reqs;
              aio_nr = 0x80000001        <-- aio_nr is updated here

9. Line 868:  err = ioctx_add_table(ctx, mm);
              returns 0                  <-- ioctx_add_table() is called

10. Line 877: return ctx;
              io_setup() returns 0 and the context is live.

You can check it in under a minute:

  # sysctl -w fs.aio-max-nr=2147483649
  # cat /proc/sys/fs/aio-nr
  0
  ... run io_setup(0x80000001, &ctx) ...
  # cat /proc/sys/fs/aio-nr
  2147483649

If aio_nr were never updated, the second read would be 0. It is
2147483649. The context returned in step 10 also works with
io_submit() and io_getevents(), which is only possible if
ioctx_add_table() installed it.

The early return you describe is real, but it is step 5 with the
default fs.aio-max-nr of 65536. That is not the configuration in
the report.

I am not asking you to take a patch. I only want the record to be
accurate: on this path, aio_nr is updated and ioctx_add_table() is
called.

Thanks,
Cheng

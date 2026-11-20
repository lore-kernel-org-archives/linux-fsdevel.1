Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185249;
	b=T8FXRcCHI4pylq7U2W3qtkdyHp+cAS29u6GRVi1SXtGUZ4W9XfdvUOma1SqIj8KErsR8
	 9HyavbjgVtxGBAM07ze+y/X3dG6LPLLmgaIApoyeVVTJr/jJV0EJFr8/Bn+daasvotRhR
	 xoPOR2HmArimL7DRdZD4Dbkt4H7AujHVqiojqPUB6W73XHvX2lUS65E+eWFe7rqIO34hK
	 XJU34dyeHPZOCn6kQQk5HNGU4vTfKTSF2xuauD3nzW9n7RGzr1qtjk7vCev/cv2jmwYf4
	 OPfFu4Ue0A4/8B+v60fniIMSOjvMNrNsQ54pou4NpxLrFmISTd3Nqi6rX6Qo25ALuYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8zhTAZY7oSFShyaCtYnSLEI3yUB00f/zfvDFBFlOS0o=;
	b=sLHAzobpO06mCPtiIFZcyv8ogUQyFGOqNIDznQBiGubpPehChW/RA8JNv2uax68AVb+j
	 fJ0UvZHj5QwySodpxM58tyXWODLXU8cnW007oDr/Z8eu249yQVrXJQeKvM3FnCaMWyFDc
	 VwpEn+smtPx9SG8dyHKtBZXP8GkQY5OZsD+H47+ohDbMI3CGQB9Bod/XdOy5kWm2g5yP8
	 YhSt25hPYERWgry3cHiti9y015KIBisy9mIeg5GvFCVtNzGrnL0pJAV4dh6mgIgu8aK//
	 9Hars5K0aP3hUN0xergRavIDrVMVL70+XpU0SWqrumenTx+WXuYqZOPC6xiioDi0XvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="P/G7VPYQ";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4E1606A326
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F4E1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P/G7VPYQ
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ee23ca87eeso132705ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795185249; x=1795790049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8zhTAZY7oSFShyaCtYnSLEI3yUB00f/zfvDFBFlOS0o=;
        b=P/G7VPYQCP5kwQc9GvpQ70smbQdC4eH9Ns6avrkgFcOXRQ+8dNzKwASxuZfdnXiwsQ
         z4BdraQI4BsKzRMZX2vEjssDAjDy1dmI2PANpmhxr5NQ2n6uvSZip1bVxOwzOrARoTCP
         miLLnDjZxpf7dKoc+yxi7EH+YhSMiMr5XSjy01lzABqNrqiPi96Y29zeMYTl6usjVbJA
         8p2PwLkDG7niPd9VY3gdOk5pRgtwMfqZGBTc+GQ0Wk2ZIwuvlN0416w6m1inmyUaYRJO
         R16UL3FkK5yVp6sOptNfzccW6xptQyeijxEKwYXZwItAhvHGmLHZy+O/iKXjRdR5/Xta
         PyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185249; x=1795790049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8zhTAZY7oSFShyaCtYnSLEI3yUB00f/zfvDFBFlOS0o=;
        b=EW+F/67vrkBG9ZbkGq+Rn39McSkAs+WbTawClw37lh+L7lb27EM3LveoiB2mblh2ZE
         w79GVk+NHykELNetHG78gRE6sG8Di95Zm/ZY6/oVDRVA0y3AldgcfIvuVgYCOr3/YkBt
         B5z9c2J2B/x00lVPYzSL/MpRwblQuW5frMjZ1hnnDLR9Kv5OAh6mtdQcvbSK8zlqtRW/
         uOg8QwCO2lDbcQAftblbuuRt2XbUdYtxwEIUd7luSUXHOuNwlpMrphiDUbd2hacuCFtL
         vGhVmQpeXMS1GVKfgnLCvwj81lx33FY0UBtcg9zsfogzSBJqOvunxOEO9rdUiS2EYoQZ
         EeYw==
X-Gm-Message-State: APuU4Z9HJPHXG3kDOFWLWqTIbhZ474hjr6NL0+oJ3mNbm1sdO+g2LD0l
	JbSGEJM8DNbnWHOoA0JhyI2V+1cgv+dn95IJe0I+OLaJJQjIWO2BiMwM
X-Gm-Gg: AZFdTZeLanpc3NuzckJussiyCdBz9PQcsv/34VBuFzoIk11L1uMgMFw2MF8PtRdhHcZ
	PR1gOij2fYvzi5y8Lcs1mH+C/d64O9h10pQ3JAzemZ/PtOYl9pAAwhJ+y5t8rOm7NrykFjRcPXY
	YCtl+1Lixh21MnWJ1Fx9W/npDrYX020CZzumMjnylbgEs1mS2xy8xZawRCBqglnHZMwq0CRALur
	o2/oW7WKwS/D2+22dGATfvEyeu4bbQtIOfpxWT3c481DU8W7jB1UvvrRcG1TcfuienU2YJCHsB6
	RJQ3a4iON2HYGukPLcCA1bcztufpUTpv4UDXT+d+OwP/HaCCOL/UJ7QSVS4iVANNXkCMKeuEUVp
	eJ8HCXCSfDg1yf9Rt4oUHXn64Om8IsWQ47+O/i0FP0YUJBT/Iio5eKA/DExJy5E3iaDm1U4rY8p
	iD5Kqaff273M8kB9jt6YFX5vEdj1E0VEFJJUQE3JZYHMyIKPNtXCHilAIObL+52S3HKzio8Uf7W
	cEDn2Oi5K4KRIWqj21hn8Drit1mKM3+Wfl+jog70UDW0Zk3Z7n7LfTkeYwZcslAz9GR+hcBagvT
	+SgB5opbsRDQtBJKq4x8ixqw+vhC1q3ZHA405SXBboiG5vjCzCmaulMKJt858nS95UrdmeW0Oxo
	OGilw30HPz4o29Eg+KEexKjDmzg==
X-Received: by 2002:a17:902:eccf:b0:2e9:9263:a58 with SMTP id d9443c01a7336-2f03f0c2295mr57011025ad.1.1795185248619;
        Fri, 20 Nov 2026 06:34:08 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1f42sm15137815ad.25.2026.11.20.06.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:34:08 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chen Linxuan <me@black-desk.cn>,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] pidfd: use one helper for pid namespace visibility checks
Date: Fri, 20 Nov 2026 23:33:49 +0900
Message-ID: <20261120143349.979-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
References: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 20, 2026 at 02:42:08PM +0100, Christian Brauner wrote:
> The pidfd api checks in a bunch of places whether the target of a pidfd
> is visible in the caller's pid namespace. pidfs has
> pid_in_current_pidns() for PIDFD_GET_INFO and the namespace and task
> path ioctls. The pidfs file handle lookup open-codes pid_vnr() and
> pidfd_getfd() does the same since Jiwoo's fix [1]. pidfd_send_signal()
> walks the pid namespace hierarchy in its own access_pidfd_pidns().
> Yuck, unify it.

Thanks for picking up the fix and for the follow-up.

I went through the three patches. The equivalence argument in 2/3
holds: alloc_pid() fills pid->numbers[i].ns with the ancestor at level
i, so the ->parent walk in access_pidfd_pidns() can only meet the
caller's namespace at pid->numbers[active->level].

One nit on the 3/3 changelog: process_madvise() on another process
also needs CAP_SYS_NICE and only accepts the non-destructive hints, so
there the cross-namespace case already needs a privileged caller.
process_mrelease() is the one without a permission check.

I also ran the series in a QEMU guest, on a v7.4-rc3 based tree with
the fix applied, as uid 1000 without capabilities:

- caller in a child pid namespace, same user namespace, pidfd for a
  task outside of it: process_madvise(MADV_COLD) and process_mrelease()
  now fail with -EREMOTE (before: -EPERM and -EINVAL),
  pidfd_send_signal() still fails with -EINVAL and pidfd_getfd() with
  -EREMOTE;
- caller in the target's pid namespace: all four return what they
  returned before.

The review and the test were done with the help of an AI coding
assistant.

For the series:

Reviewed-by: Jiwoo Kim <arpe1618@gmail.com>
Tested-by: Jiwoo Kim <arpe1618@gmail.com>

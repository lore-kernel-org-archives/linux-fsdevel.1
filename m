Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044C2D8385
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309589; cv=none; b=Yu3r/Vzw/q9JGLHRt7NIXcNOB5TaiT5kPjrI0abXvUtCyhh/Yyg53LJhx6aTvtQHwQ7m792AWoWRdNa+Uu2XNzQrmwrCCcaRp2VlGxe+hjgJuftpBwMlnNmG8aMNnoZhAkUPVCkUcFobWcJ+P2JWH79HZnxvoXkSl08FgLFzwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309589; c=relaxed/simple;
	bh=A+DjUexp/f2tvqbIAjUU7I4qVACxg+kyLLN9p3KCX2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4+jOOrE3nU40Y0hvb2HQBEnPuE2eTyXWb0JXc5Asa4LHpdWc39P+7DGZutDpvN+GxOM5YibsITGwcDFR1Lig4scBruesPCRxLlsitacd5Q8UXQou+7pOzL2DYJuqyZ/9qDAqRsRJh9nMMoPkl9z10voqlytL2laBct4MRdKqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=qIUzUeUZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qIUzUeUZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-482f454be5bso52944705e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774309586; x=1774914386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbZujM3FV5nuEe07RwHpOIgGdJI2pk6HXAsvClUkyg8=;
        b=qIUzUeUZbX9m86xCzA+K4G+X5MJSJehhGyDOu2IHJJ1IZj/cjRX9byLTnViK9fRwBH
         eilT+ZIkK11LyC1K/h3k0TAc0ttktgvo5bC20A0ZM1xDIIO0kZNMXMtolO+a4PRTo0ce
         pxgGyjfW8K+8x/pgLRoZFBj67V9j/duDlAS1I6haiPoCzmPks21Cpl8W7talssrfa2Wm
         cFU9OHzX3Z7w35Fg4ZECdFXTuEDFDH9Q7F7plQV7JYlD1WZKgdppJ6qAy4OrCla08x1w
         R7rpTDlnc+Fp3VhWi6Qtn/4Q1o1Qx1AHkCAGpXlMp6rzaNLnSQbFZQ6mFjodERun+gS8
         6bHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774309586; x=1774914386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hbZujM3FV5nuEe07RwHpOIgGdJI2pk6HXAsvClUkyg8=;
        b=K0eOxOfz4o+VoTqgyBRfwFC3RMMWDOn+m/j4t0DBnFRDbuqSPb2pdKd3rtZxA8Wde8
         dyhNXBsaoqsTpr2lZtm9eyDcUzDW7qqDjo9QAaA0UVG7e/0uFr3RwVSrj9GkiVZ7PY8I
         NhyFmAwdw26Gu6R3PV4EqK5E67bgvFDyTkvVOT2iLdRJOUlwK/Hs0QG4OSRrtprQWrar
         s53Sa9yLCgcE3c9IuZtKuDNiXiKmC3wlgOPkgVouU+UPr+iHIBFBQloaniklVOOAkVzQ
         nOVdH3UXCnByDxTcvJvrKjS0flkNFIggzui8fRBz49pIeAnw81UaXbxQWcavr1y+HuWB
         K3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCW994eetXMxldeMgrkuzI9bv5AdR0ONoFqgHWgKunwY/AcMQIVXTRRTiRrCGdznmevpPNeimoxx0lNoMKeS@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDWPvRv0TvYCQMhivEykLzZGy7l8iAosix9Zgd18mPCGShHLr
	pjh9k3+TAkSK/t8w2zG1YilAfaS9vB5ZYHzYxlXW03f3tia08gPbjqNQ
X-Gm-Gg: ATEYQzwmc3QBGCFv48SH/buhtsyOHzYvMFmtlUVcs8DONWP0h1xj5+qVuskEKMwEfMz
	i4THlSveKeh1GfbshXjnOWO/1RWf24lEg+awzS4NxvOcfILQaZty+uSx1+1pD31FuLr1wpqtNof
	fqVSZ2AXsKeYjreHP6i7JfbXt//WtERClDsTk4WA8HReKLOJfSn4AYM+SmFW96FYy3219sW6lsV
	PPBQnjnsZI7o6moZSYHdQ/IXI1pEL0VjJeoHtBRquSTFk2fJSXwpiGd6iExLTRhrzcgRNIce5vr
	AeGaHxEL8IQzEDiq6XsOGRXdYSe8v7gHM3L57zAu0y1CwCDkl+j/y7QoSgQfnlyncgFtcLqGz9j
	MV5zOY8IEe+RNATtLTTTqgHvI99JOnD1Nej2nLZ38VwoxjrC0s/rp5cuBKa2SvQrWyNJWQOsg9B
	GFu9TDOCe6Jto0SfuO0kc=
X-Received: by 2002:a05:600c:8b67:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-4870f202618mr18805405e9.10.1774309585915;
        Mon, 23 Mar 2026 16:46:25 -0700 (PDT)
Received: from DESKTOP-I0B9J3E ([2a02:8071:5392:3220::bcad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116abecesm6560775e9.5.2026.03.23.16.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 16:46:25 -0700 (PDT)
From: buermarc <buermarc@googlemail.com>
To: joel.granados@kernel.org
Cc: buermarc@googlemail.com,
	davem@davemloft.net,
	elias.rw2@gmail.com,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opurdila@ixiacom.com,
	ps.report@gmx.net
Subject: Re: [PATCH v3] sysctl: fix check against uninitialized variable in proc_do_large_bitmap
Date: Tue, 24 Mar 2026 00:46:23 +0100
Message-ID: <20260323234623.689612-1-buermarc@googlemail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <wcqe7kk2jdca7otlp6iwbp27ud6d3ynzopr7gs66gqn4xeskbr@cdyrjkouqmem>
References: <wcqe7kk2jdca7otlp6iwbp27ud6d3ynzopr7gs66gqn4xeskbr@cdyrjkouqmem>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joel,

Thanks for the question.

On Mon, 23 Mar 2026 14:53:51 +0100, Joel Granados wrote:

> Here I have a question:
> 
> How is it possible that the buffer in proc_do_large_bitmap is not
> terminated with a '\0' when writing?
> 
> The proc_do_large_bitmap gets called from proc_sys_call_handler and
> before running the table->proc_handler call, the end of the buffer gets
> set with '\0'.

This is correct, the buffer will be terminated with a '\0'.

> trailing char is '\0'. Which, in turn, means that 'c' will always get a
> value.

I think this does not hold true. If the buffers is parsed till the end
len can be of the same value as size in proc_get_long(), which means we
do not set tr.

I will go through my current understanding for a
write(3</proc/sys/net/ipv4/ip_local_reserved_ports>, "123", 3) = 3
syscall. Hopefully that will make things a bit clearer, or show where I
am mistaken.

In proc_sys_call_handler() we call the function (in our case
proc_do_large_bitmap()) with the count based on the result of
iov_iter_count(), while ensuring that the buffer contains a trailing
'\0' char. So the buffer will contain '123\0', that is correct. The
passed count will does not change it will still be 3. I used bpftrace to
check my assumption as I don't know the iov_iter struct all that good
and it holds up.

    The trace code:
    sudo bpftrace -e '
    kprobe:proc_sys_call_handler
    {
        printf("Count: %lu\n", ((struct iov_iter *)arg1)->count);
    }

    kprobe:proc_do_large_bitmap
    {
        printf("Count: %lu\n", *(uint8 *)arg3);
    }'
    Attached 2 probes
    Count: 3
    Count: 3

Where the output is triggered by:
write(3</proc/sys/net/ipv4/ip_local_reserved_ports>, "123", 3) = 3

proc_do_large_bitmap() takes the given count as lenp and sets left to
the value lenp points to. left is then passed to proc_get_long(). This
means size in proc_get_long() is 3.

proc_get_long() calls strtoul_lenient(), which parses until it hits '\0'
and lets p point to that. See in proc_get_long():

	if (strtoul_lenient(p, &p, 0, val))
		return -EINVAL;

	len = p - tmp;

Setting len to 'p - tmp' means length is 3 in our example. In our case
size is also 3. As such:

    (len < *size) => (3 < 3) => false.

This means following branches will not be take. See in proc_get_long():

	if (len < *size && perm_tr_len && !memchr(perm_tr, *p, perm_tr_len))
		return -EINVAL;

	if (tr && (len < *size))
		*tr = *p;

This means we do not set tr to what p points to. Also we do not do the
!memchr check. This branch would return -EINVAL if len < size holds true
and we do not contain an expected trailing character.

We can force the !memchr branch to return -EINVAL, by using
write(fd,'123\0',4). Here len is again 3, as we only read to '\0', but
the size is 4. This will, as expected, now return an -EINVAL, because
for the first proc_get_long() call we do not have '\0' in the set of
expected trailing characters.

See tr_a, and the first proc_get_long() call in proc_do_large_bitmap():

	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c;

        ...

        /* In case we stop parsing mid-number, we can reset */
        saved_left = left;
        err = proc_get_long(&p, &left, &val_a, &neg, tr_a,
                             sizeof(tr_a), &c);

For the second proc_get_long() call we use tr_b, and here using '\0' is
valid. The resulting behavior feels a bit unintuitive to me. I can
understand why based on the code and it likely has a some reason that I
just haven't figured out yet.

For example the following works:
write(3</proc/sys/net/ipv4/ip_local_reserved_ports>, "123-234\0", 8) = 8

But if we have same '\0' char at the end for the first part it fails:
write(3</proc/sys/net/ipv4/ip_local_reserved_ports>, "123\0", 4) = -1

> I'll repeat the comments from the other reviewers. Careful with these
> separators. When I used b4 to bring all this into my testing env, All
> your trailers were ignored.

I'll make sure to apply test output of b4 next time and check if
everything works locally as expected. Sorry for the mistake.

> *Unless*, the buffer is changed in BPF_CGROUP_RUN_PROG_SYSCTL by an
> external (to the kernel) program.
> 
> Are you running a BPF program on this hook? Do you see the same behavior
> if you turn off BPF?

I tried to see if I can access what c is on the stack to check if I
could see the '-' ascii value. I think I used the following snippet:

    # Print the specific byte where 'c' could be (e.g., RBP-1)
    # On x86_64, local chars could be at the end of the stack frame?
    sudo bpftrace -e 'kprobe:proc_do_large_bitmap {
        $c_val = *(u8 *)(reg("bp") - 1);
        printf("PID %d: c starts as 0x%02x (%c)\n", pid, $c_val, $c_val);
    }'

But I must admit this was just a shot into the blue. Yet, on the
affected host the -EINVAL results disappeared as long as the probe was
attached. My assumption was that the eBPF trace changed which value c
pointed to on the stack.

Best Regards,
Marc

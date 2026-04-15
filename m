Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A02853F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262485; cv=none; b=r7qvnh6m1MIu4q+nLrDv9UcidAQ21EvwZxvd/5nCdSkgVUCRC54UF+zjmMdq3jmIwjBU7Bzh41wnu0Fdyup56hjJ01B97XtFibD7VEASOM8JREue6pK7PjKDeCC2BYzHO7eXj3SEPxLM1pP972cFv6oTJF2SYwIKnWyXzam2du0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262485; c=relaxed/simple;
	bh=oh2ZaD0YVIXH6z71ONW01jAr7uKpA09o3YgGZotFJA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5GJ2KxYpBDqz4XVlar3hb+TSeNppreng1j5HK/CJpxZ79k9wXhCSgqXK28zmoXdidSIkDxfwmZcnbeDEls3vXsorpFQM8xmkdiQL6Kajd8Q1Fx/AJkNlB2bWzSkcW+v3IWxuAHvRDR5rn79Ylf03SrNI7n+6W36StkqzkdMEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENtZJi8I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbunACQO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENtZJi8I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbunACQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776262483;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KRtbM5vRtC+90vFJ9CK7bzztdcwxjyK64to/dX/3L8=;
	b=ENtZJi8IOXQ+IOy0RFICFEIyg/43p+3t8sgbu/C0peJI5CWlSVLh7m+C3yRJ/VW+aLGzAV
	7bW9fZIwMIgKZS1WKxue0EHorm6AEGtXmdNFmDcBzWdpTg4vAde3es5gjuf1jL+TF8LD7C
	Ggau/azNyS0ej1r4LE97B432OjoEUXE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-QtvnGseKMIum0Z-NeTDfzw-1; Wed, 15 Apr 2026 10:14:41 -0400
X-MC-Unique: QtvnGseKMIum0Z-NeTDfzw-1
X-Mimecast-MFC-AGG-ID: QtvnGseKMIum0Z-NeTDfzw_1776262481
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d5d03ae893so1179409985a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776262481; x=1776867281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7KRtbM5vRtC+90vFJ9CK7bzztdcwxjyK64to/dX/3L8=;
        b=ZbunACQOfOMSjEzO6D/+YjdvPrS7HAcLgB98mMnIxmmnInA1l+PJzSmxcWCgnKr8dh
         acl+aOjnl2r8uC3zOdQ4IcxzmpJuIX9KkyWjqW0Ah8sqO2xM2CEs7I0f6W5Q+7GxcIk0
         t0y+LQ1eGIT1rKij+0IxdriK1mmqxORC0y7AxIv+OXXDQ78yDcwOw6HBbJdM/n8oqubn
         FfOQOVSao6U7ri3wyGiXYOuRsr9b2pw8RPW6d9838iLdHj26FZ37yQIphweGSAO1kotb
         JS05f0g+7DmANkyz72v/MdIEejwNUF590atBnoZ7Rjq/R29IHTYMN409CCog/SX1VU2/
         zqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776262481; x=1776867281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KRtbM5vRtC+90vFJ9CK7bzztdcwxjyK64to/dX/3L8=;
        b=mBs4FIflolJenpsf6asaOnj+8PKUTBt5S+dl37On5nySFiOYCrAJkrsdvivxUqYu2k
         4CK4Ptb/ZP4lyLb5gIOeTILJD/yTEqIKFmw10I2ntM1mq4G2Nw5AFyH1qaHUWZgvMykk
         PDtB+Ah6IVjBJq9iZNDPTLtx1ruqzpy0YnQmZwz2IouCmYJYkanoXbT52lOYpeW2VG6R
         NIDaeD+lEvqxhP29eQ6lWic9DU/AOdPaHq+cRz58BDpG1ljy2nSeqLf125suxpYcGLiE
         9u2MDnBFh8SC4n8tRzdTeG30Kz5nfvzvbo9QbOMwA/c79xDYqrb/7U3X84fKu5FPYlSc
         X3vg==
X-Forwarded-Encrypted: i=1; AFNElJ+X8Q5lq99hfl20fNU3qnlklGPsS40dJov7R8jT+F5U5yg7q2qS7GLodn12jxODpa6GLKKpBx59BBTd8PBq@vger.kernel.org
X-Gm-Message-State: AOJu0YzT46iVBkhsnXJY7bnXZHGE1cOUZq5fE4l94HnqGl9V49FKIUTm
	1JUuMZIMRNAYiL/57CW0nWTjReKWwZxqSG+eifENCMEdYUong9RA0DRbbs4ipFOrlCqE80Su8BP
	pqXoMbVFtOKwv0UoTIM0U0oqDKbAgPIAHaFmrZ36OdttkD65D7ghsZHlRDsqeuKJo5Es=
X-Gm-Gg: AeBDieuOwUo35J/7R+3VX2AH98YnexXhjRNtxv/1bdr6i8mw/YhVkYzHMPjiPJHpYP9
	i0y6tlzwodfHSXA28O5x+802NmtVo52ADU6gNvM2FeNK7X9O87z+ACoQX6T5szEi7yWJB/ubZW2
	uCWs5Gv9yvroV7xN//3qDXBld0xQEjFthaYCRWuZRQuGMcmqCvfI/8rGdryaKvoM9QMfIVrSr1m
	AdRH74REOKPfLSb/LELDOuu6NNPMuYClGjPwC0nDTfU/OXId+IjFAmujg9k/RBgV/W7XYobwbHL
	QoYw2zCdRYW53H9XYtTRvfMMMcXzUYk1hJbbwkq+tMoKVH+gR0xBw46TSNYnpKmZGzmy0C4RbPD
	bzDBRskbRGG0z7kGU+mRhiKo/VNluFRag2XTjoG1b9/ZICo/xspO0Nsjp8lXhDYf2ZLpYnf8P
X-Received: by 2002:a05:620a:29cd:b0:8cd:982d:411d with SMTP id af79cd13be357-8ddcf6b6995mr3111044385a.52.1776262481208;
        Wed, 15 Apr 2026 07:14:41 -0700 (PDT)
X-Received: by 2002:a05:620a:29cd:b0:8cd:982d:411d with SMTP id af79cd13be357-8ddcf6b6995mr3111037185a.52.1776262480611;
        Wed, 15 Apr 2026 07:14:40 -0700 (PDT)
Received: from [10.0.0.83] (97-127-66-40.mpls.qwest.net. [97.127.66.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f31f95f9sm143932085a.43.2026.04.15.07.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 07:14:39 -0700 (PDT)
Message-ID: <dc04b435-88c6-4b7e-802a-59734afe3184@redhat.com>
Date: Wed, 15 Apr 2026 09:14:38 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sandeen@redhat.com
Subject: Re: [PATCH] xfs: flush delalloc blocks on ENOSPC when creating
 symlinks
To: Ravi Singh <ravising@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 djwong@kernel.org, dchinner@redhat.com, cem@kernel.org
References: <20260415071657.23412-1-ravising@redhat.com>
 <ad88TluB4FIP3yJV@infradead.org>
 <CAF-d4OvKZOsez5589KUYTjRz05PQHCQ-uRkXu-3iaO3tOjcavA@mail.gmail.com>
Content-Language: en-US
From: Eric Sandeen <esandeen@redhat.com>
In-Reply-To: <CAF-d4OvKZOsez5589KUYTjRz05PQHCQ-uRkXu-3iaO3tOjcavA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/15/26 8:24 AM, Ravi Singh wrote:
> On Wed, Apr 15, 2026 at 12:51 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Wed, Apr 15, 2026 at 07:16:57AM +0000, Ravi Singh wrote:
>>> When creating symlinks on a nearly-full XFS filesystem,
>>> xfs_symlink() fails with ENOSPC even though space could be
>>> reclaimed from speculative preallocations. xfs_create() already
>>> handles this by flushing outstanding delalloc blocks via
>>> xfs_flush_inodes() and retrying the transaction allocation, but
>>> xfs_symlink() returns the error immediately.
>>>
>>> Add the same ENOSPC flush+retry logic to xfs_symlink() so that
>>> symlink creation behaves consistently with file creation.
>>
>> While we're at it - do we also want it for tempfiles and scrub?
>> i.e., should we move this logic into xfs_trans_alloc_icreate,
>> similar to the quota logic?
>>
> tmpfiles and scrub tempfiles are created without
> directory entries, so they don't need a new directory block
> allocation and don't hit this ENOSPC path.
> 
> As for moving the logic into xfs_trans_alloc_icreate(),
> xfs_flush_inodes() is a heavier operation (sync_inodes_sb).
> Pushing it down into xfs_trans_alloc_icreate() would make every
> caller pay for that flush, including paths that don't need it.
> 
> I think keeping it in the callers that actually need it
> (xfs_create and xfs_symlink) is the right scope.

I think that's correct. I had looked at this and came to the same
conclusions after also thinking i.e. tmpfiles needed the same
treatment, couldn't reproduce it, then realized it's because it's
directory block allocation that needs the freed up space, something
tmpfiles don't require.

Thanks,
-Eric


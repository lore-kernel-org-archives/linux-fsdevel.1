Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5640DFDE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411119; cv=none; b=bUQwYOzK1HhhCrq0ECg3PN6WXgJTFS3BPfGA++GSVd73PuCUj55KwN+cmnQBOSzBx8Q87TmEf69CfTxt8wkHb3WML7Nzwsd7Fs0I9Vo+XlnAFqqb8dY3vBNlEkxy7177HIq/2t52vkJ2nxNogRl9V4Gf6wOcRDJ6Kr5XqFgj6vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411119; c=relaxed/simple;
	bh=e232u/Y12qKTZX5OlS3gcTSH0tBMZOJ1MXCtIWOiahs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfRrQE3YBkpzBksuOi71UNpXHeUdQSgqr6pE/cSt9KGzCZdZXLfCfXXlbkaMMmvlMca+NSMlTaqroiyJYSTbk/Bb9vTZxStrsLgE56AKoKXfSvNceAyXaIFJXc4CEW6PaDKwWz9o3mt2WFDfkGr95kFpqjccBXIdSduQs2mnDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LApwSbOb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kHMaUF5B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LApwSbOb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kHMaUF5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785411117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/oim8867mZQgToMOzPg8eJIB7HeZ+BxcHHpVKJYTOE=;
	b=LApwSbObI7GSPTGzDmGnR7ty4ZHGdcYCFqs1tDG3seJebt34uC3VD96IfBPSaZGJ9TURoS
	yzS980fTJ6Dz9fBYGhOtSQzRdIaYAgAAozEPx5uS+v4NXarhtsT5GA7I8aZFeVguYIRRBK
	y5kQ6tjQm80FBKXy1Vq9s7yaXTiSEnE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-XOIh2WcAOD2AXC4vdUd8mA-1; Thu, 30 Jul 2026 07:31:55 -0400
X-MC-Unique: XOIh2WcAOD2AXC4vdUd8mA-1
X-Mimecast-MFC-AGG-ID: XOIh2WcAOD2AXC4vdUd8mA_1785411115
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1c7f135bso36207931cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785411115; x=1786015915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/oim8867mZQgToMOzPg8eJIB7HeZ+BxcHHpVKJYTOE=;
        b=kHMaUF5BCdSpmSznZkHS31hopq2iXgv1yf9Y83LczYRefV26hl7/Xhun0s+gNPNfF9
         kNgS6pgZRj0faTdMppBZ7OGJ/ZAElptDnvT04y/3QDY6OI+wdl4U2nBYIsbPakj1jHGK
         A0n8rXuUq24RKgZvuuKsSrjjfA49vOg1tkwzLkfCst8ZOfwe92hagztGl1Wmc7327IK2
         1BgU9iUI+idKf4aFai4NWC+gfr9nIzZB58/KA4gQ42k4p1PEJiDLZu3OEnushCkw++EB
         hV3EiIO+NS5FVnsJDB16VUXpEzyVWcZXP3Kcp6g7H6MAvwQWdOkd5aYf6+hY5wI8QuL2
         YPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411115; x=1786015915;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/oim8867mZQgToMOzPg8eJIB7HeZ+BxcHHpVKJYTOE=;
        b=kI1N7n7m/tJ/kDpdq6C8GDwGEkb7dEpvR0xUvMjrJnenTwO/Er8uASAw5YnvQOmQ0y
         zc7RpgU3XFzxrDEFuwV+6V8dg/g7VRXDbxEyW3itdzrAp4twpRBxvhVgTT4TV/gf/mc6
         dNzl4Kym6DdJ3WL7JU3MaE1L7m9oipiZXM+XaeVLa0Aj+ASvTWIe7fKuK/Mu7oMuLucV
         Vi0cRWIKRRr9uCaTtFAqKibADfsvP///MXKmVFx618vYp9XB7HlZD70h/bMgK3KWZ+7W
         NOSwq6YX9gOX1HQl+Jx6rV6Z0y3vozV5lXFh+8/Lk8Li/Fz3lr5z7TRd8vQJ4w9xOgrC
         ESgA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2Sxy8LdAtmero+6RiRWKOHkaiE5v7TkjV1ZzEcZx+nG3C6Jtqa0l69CPbk6BNFUcfTZa27UjGdMNIMKzG@vger.kernel.org
X-Gm-Message-State: AOJu0YwAG/1MRnSE6DzN1lOXu3Zuf2znoX08R/A4h0oxGj3Pju4zjC1k
	ZXYNXDHht3YD4T1wVl+gqSbu+2MzYG368Tt+QZreCFyYOn+npBq5TezICVoj9QlDkhYTBAEIWQ1
	DOfbp3AiPAy2ffl6Ulxjn4sPhMj2nalmUBrIdH0mR+g+HfdPEqx+rMVzFnBZwTe3+DbqtYt3laN
	k=
X-Gm-Gg: AR+sD12C2iHhUVB2TQ8jdtzkG4E+TUleD7kfH9QPXh8e41JR730GbY4aQtcSgsVHkMY
	c62y1wiCiT8s1pnCqzSgShn5wcd+KZwiqSYHZIAztz6DHxVeQY9D2a6+najQ9/Za8xEGrM5hZo2
	/4qJxo5dkaSYt7nrflx9bTGMDxOHYObLqo4mDTwGnOouaP4lP3+2Wrqlw58bR/vJUBqg4WAWlQz
	YF8hVTNnZ5+bihOBHqwLR6nYlrFVk5Qjfknu1fKFAMudkbgtBt9H361AyLTUFo/ZMQ//LSbmguz
	DijT4c6aZ9V6LhCy9vaVEHXmOOg42ksYSG8JNV3n0SLQP4J0Yq8sauKKF9FbxcGq+9UEvff5T5c
	P
X-Received: by 2002:ac8:5750:0:b0:51b:ef2c:7bf0 with SMTP id d75a77b69052e-52b384c6e18mr21435421cf.35.1785411114711;
        Thu, 30 Jul 2026 04:31:54 -0700 (PDT)
X-Received: by 2002:ac8:5750:0:b0:51b:ef2c:7bf0 with SMTP id d75a77b69052e-52b384c6e18mr21435081cf.35.1785411114245;
        Thu, 30 Jul 2026 04:31:54 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.250.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908324f3099sm15731886d6.38.2026.07.30.04.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 04:31:53 -0700 (PDT)
Message-ID: <c62e53e3-139a-43aa-bc7b-e4c3d47fa6d8@redhat.com>
Date: Thu, 30 Jul 2026 07:31:52 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ANNOUNCE: nfs-utils-2.9.2 released.
To: mjnowen@gmail.com
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <dc0f6f41-84be-4a70-92db-89890bded3ab@redhat.com>
 <CADFF-zfEws+xZ_tOqhC8uJZAFZvwMDtZ5yagDP9x7Umq6zabDA@mail.gmail.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CADFF-zfEws+xZ_tOqhC8uJZAFZvwMDtZ5yagDP9x7Umq6zabDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/29/26 11:14 AM, Mike Owen wrote:
> I don't see this release tagged via git here:
> https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=summary
> Forgot to tag?
I did... It is there now!

Thank you for pointing this out!

steved.
> 
> On Wed, 29 Jul 2026 at 15:48, Steve Dickson <steved@redhat.com> wrote:
>>
>> Hello,
>>
>> This is a fairly large release...
>>
>> A number of memory leaks fixed (from AI)
>> A number of netlinks fixes/enhances
>> A number of exportfs fixes/enhances
>> A new nfs-iostat option
>> A number of gcc/warnings fixes
>>
>> The tarballs can be found in
>>     https://www.kernel.org/pub/linux/utils/nfs-utils/2.9.2/
>> or
>>     http://sourceforge.net/projects/nfs/files/nfs-utils/2.9.2
>>
>> The change log is in
>> https://www.kernel.org/pub/linux/utils/nfs-utils/2.9.2/2.9.2-Changelog
>> or
>> https://sourceforge.net/projects/nfs/files/nfs-utils/2.9.2/2.9.2-Changelog
>>
>> The git tree is at:
>>      git://linux-nfs.org/~steved/nfs-utils
>>
>> Please send comments/bugs to linux-nfs@vger.kernel.org
>>
>> steved.
>>
>>
> 


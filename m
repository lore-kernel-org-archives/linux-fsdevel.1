Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686757;
	b=Md6gv7qzhSrULayy20Le5IA1tirH+KhmQfwhGCuIVhh4Ysj8CO3TcbXe+hAuiKVW/WJ+
	 b9K6K+Bv6IUbxzhU/qjRgbC/rvKO1Ngt+vqw9x5RMSckeZRH3aw77n3nNglwkHgOJjnFF
	 /kfhjtC0mc+fnKkeOnY8065L6ZxfR9/itZ5l4ppDV5W/lFANUe3JKGswkbYOwJh3XngcB
	 r5RypiVaBYjycMSlHsP8IAyBR0xJUCZ0186dEOo9bMszm+gYxib4Bo8n7KyKy99WzKu+M
	 3GCkGYM1dJoryu8qEg6dOYB/Ld8O5UpJX23/cU4kXJkRCq5wjxaUoC5ygL50v3catNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Message-ID:User-Agent;
	bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
	b=NkPP+yXxVQTG8RkA6rqIgRXGvbPb1qooe08h3Q9mYOWtyABUJ0wErgMSrRXQ20KmPIjd
	 46rFFUztqPtmlJH3OTdsD9JA5q7lnYQMo9rD9WCztaERq6bZMXSBHXEoqH7Y/tyRafxsg
	 6RTYWfZ/RP27s/VmAYtSvTnHjvLSq9i7FYKwkwpKXCaGhZLLMconWgIA4ZQDVj+vq1Mom
	 5DB0wt1k9BeUp3LpaJk5EfXrXc3U+4dlffPa0LpceNP/F1oamozc3oQ8zQeorx9yhs8Yk
	 hcuGhYey5qTstivXnvKLVzuEeurLHK7EnBHTNBycCfJPsGPv/K1K4eM+v7477Ud58ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2854606A332
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 20:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2854606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ZNpsvJMi
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b271e573adso1161061b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686756; x=1795291556; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=ZNpsvJMizOoFFuviUq3R3I7xBszXKHR6f+dU2Lhp8+AdJOsuucW/Jpjz4DKxOc01P8
         7Bf2gXYBYorSyL2ypHSps7l13uEx7uOW/BQ3oCjgyM7fn4nszFId/ZhifmOhhkUhMak/
         Krv6vg2ZKrT882kZ97nfZeCj+rR5WiJ1p/wW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686756; x=1795291556;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=zsWOjnYwCFnopzbPx6Z9jXpGmJBIuTB+3kvEOSWcnWANZoslkXUw/l/DOYbeVQ2jER
         GMVUHF3IXffOBxSHJWtJf3I016QC3g+WZcdBiuPFhIj7pS1tAhuGwZ2m9oMcX0qoYxeX
         q2B1F2w1WeNivkMeusnrAx+3/QzckTJF/B+UdBkSfe0VBRfA9z9VUKdEjW1qHCCOn7zf
         JlgGhAZstc9kGZdOcnE5Mu3xVZIoiNE78U8Beo9n4Kr20nyDQJ3mKsszouisvAIfksoK
         7xVNLLQsGsiOLKSRwLEa91MaIC1M9nuGaMIrXz6QSY6NYFKh0O2RPArbLoqf/OdMvWVx
         S0JA==
X-Gm-Message-State: APuU4Z+24vgCjqCmouy1V0ieMXlB1XbRfw5AEsxCpfhnpl1QNjAwDhq/
	j88cOqjb4sfK1d0YT6g8OYCeLfrAY8V90T59bAJB9qGqrEq5kMFkBt+43WqlHHT5pCA=
X-Gm-Gg: AYBFou2vWUgdDhnvtyhefM06jciDzvSvBqHGb5Zmq/D9MIMEmgfkX3i2k77PNDqn8Lp
	YK4Fv1wWui/Kv/aI4bLqe/wO8JHBxbgdQ/+8zOs5TiVJivxx/K3L24581X6jx3gxcEHrTLW1cNj
	GUZ7Vu+KTZYMdE3aj9Qv59VkAtNWRo8MVBrgYxd2mJnCB5lH0APCCx359PqYaR4LECipxNWr783
	01jsc8zztxXKPaR6/2E6vmuInSVN+nwn1tJYyOE6kVk88iNmuRYxyyXBiFw1mZlfYBAmvWdYRaG
	sLR9Y/bL3kj2JVV3XXTCmtoHU71Tlqe6MqEaXqe5hrBqjWXWSkxD4utqylgXzjQ12S7FaCX/J9G
	xJtqfZ8VItr3Res0Rbx0zg60jpPvqMAvQoPImeo1I4uwdmVGtlu5QvnAKQOp++KkT8iQskuFk7Q
	T23QFHPDrWLEgRDk3WwWiemztPRlyQeXhUSNvQzusEG93lTiHJHtUmutW3/mIiuoEHmcivJ43F4
	M+mQaqY79CywCMZHlhngsD3Hmt1IrI9KGB6JGbxjQZjCJH5U8vlrOIvv9ECiJ33PUD535DTAoGi
	Ha4KloAQzfUE7FpoC9FW1/n1XEFAyI5K1/VsHsl3QJYyJDjywv7wSeqTCVVMFzMmeHCz3r3aN3r
	bFEi9b7BPjJ3l8+Yk8vtYZgjpgTo9T2yH3G4r4+h+UNCSYWJwI4Bdvb+nU6NfPuBcEU7WE0xkSl
	naTCtxNUkF6qUeR0YLnAn8OfSTO+FfuUP5pQhTz1CkOeiLZKxigYpL47ON
X-Received: by 2002:a05:6a21:748b:b0:3e3:37ff:3795 with SMTP id adf61e73a8af0-3f7a4dbfbbfmr5517650637.7.1794686756009;
        Sat, 14 Nov 2026 12:05:56 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm2271197b3a.13.2026.11.14.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:54 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:50 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Alexander Mikhalitsyn <alex@amutable.com>,
	Breno Leitao <leitao@debian.org>, Casey Schaufler <casey@schaufler-ca.com>,
	Chuck Lever <cel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v2 00/42] fs: don't use pseudo filesystem files as
	storage
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120550.0c9e73aa12a3072c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Patches 1-11, 13-16, 18-26, 28, 31, 32, 34-37 and 39-42 look good to me,
so for those please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

I've also tested 5, 6, 34-37, 41 and 42. The selftests all pass with the
series applied, and a uid 0 without capabilities can no longer change
/sys/kernel/reboot/mode through a loop device. So for those, please also
feel free to add:

Tested-by: Chris Down <chris@chrisdown.name>

I've replied separately to 17 and 33.

Thanks!

Chris

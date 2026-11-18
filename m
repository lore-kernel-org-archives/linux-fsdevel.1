Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009617;
	b=d4bV/7TOanVx+/f93OoD48wD5bvFDCNwYrKSpL9afG2moOPwM43pgwO9UvbLLfchBMEF
	 P/prL6jWCx5pzOQGL+Q1iWSm0yLd7hs4lF8IYhH3gNQsoMbudutPqJyXJ9r2IljBYGCVP
	 0D1LR8pVNuTNKVuPX0jlafmoCvm64Xtwi1JzZIiQwonBOdyw2sDqN2Yk5La/ZLgETsJcm
	 12pv/+AKjOK2ed2Q/EFWLfw6CdqO2HORUzjH2KmGdScOsJPWia1fKBzg2jjKsr27aZs5c
	 lqKn5XD1deJEJ3gTb3geh+GhNqg83fGk0hwIS6LF/CGugGwmtMLLGWw+MK/JBEznMkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009617;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=Tle8slx6NRf4k2tH58uKxVCUa6+6GOP504/OgqZ9PWM=;
	b=vDmwi7hS6v9bgnCj0f6YI2Hl9wfwfB9LpcEXGcZWYYGHEUT9CFZWJAMs/KRdwyLgBgiU
	 FLTWh3yeXo+EmWKmzs6HSUX6doDAj0z1VIRrfOD9arMZqTeKSEneuJWvdmS8sZhtjjnKm
	 Sf8Q8TVA4gz8kaFlg6U/N4of4Ged8uUduwhxPKXq9WtXCE+xKnGCW8VTCM3XqgxozZMJz
	 po7Zo7tISMPS+xPlnSII4Q9W9EKpBQJECkvhjHhB4c0p/GFc/qyXIKO6uKpKrbvXVllV/
	 F963/Es2y/qfyRtEpYDYe48PkvW1H9uVSAyTgV7Dmd4hjMJLDggJh6Y96LMK+QyL/Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="iJmJC4/6";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=R81Vhsre;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA69606A32C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 13:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAA69606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iJmJC4/6;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=R81Vhsre
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795009615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tle8slx6NRf4k2tH58uKxVCUa6+6GOP504/OgqZ9PWM=;
	b=iJmJC4/6T43o0wKSn/TVA62MZ54e3ophj7kG0x3YGd/bdupV2/ry/mtwA3QxFD93tQhh6D
	MYhxeq1etQN+DOFOgTpSB7lUHnvieWFi5xyqX6UPuqYhW246Rrv3uNDo+JGdp3CbZQUh0c
	H07KLIruqtJ0hCvOPoixwfZM12zleoE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-gWOGZZlNMk-Xy9-lS_8lRw-1; Wed, 18 Nov 2026 08:46:54 -0500
X-MC-Unique: gWOGZZlNMk-Xy9-lS_8lRw-1
X-Mimecast-MFC-AGG-ID: gWOGZZlNMk-Xy9-lS_8lRw_1795009613
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c41dae9db9dso112399966b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 05:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795009613; x=1795614413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Tle8slx6NRf4k2tH58uKxVCUa6+6GOP504/OgqZ9PWM=;
        b=R81VhsreHTWlGNDkDLoCfwrtBiVudVSPjGVZyUlGV+6CieFE4VoJxOwwx59pYOjV/n
         0dLy8+PL8oduxX5PK3Yfiom3DRud0qUxpBUyHuQuizixpM92pD0q/u5kph4rCcOHuAAu
         6K4LPc9Ve6yZ7hRa+JWPLlPjaMHSvSdWZZ2yYtyqsS1TG3cfln+m6yXyTNqW7OTruVS7
         B9i4aDZoNdgFYy5B5jwojYXQohPP11TpqgVCT+Jn1JZTeAi85bSNZ95Wu6TcQLPn2CeY
         ilEuoyfV8H/yp/LjxYhc0qRHJ9wNglTUphybsvuBrWbCA97cY+4VfePnheCDA153WEj3
         vBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009613; x=1795614413;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tle8slx6NRf4k2tH58uKxVCUa6+6GOP504/OgqZ9PWM=;
        b=C6OqP/c7Btd+fyq95ucDPDZz8RMqG/dj69QIC0Cf/5jQnFeBdrnKYoCTC0QD8vkVK6
         Ht/FqUbXhu97QlNLgE/otwludIhS6ytB7S8b0kt7Nu8Nqh+QdxI+uWZDhXgiqooaOVoC
         BXfeo5s9Rg6Pfv/xDaCgyK3nbQLbRcZzXVBG/FV9S4FThWGFSpZe1b24lSDB4SeWLkQL
         UmD6yFdk/teOV8M6017kG8lUMKsd4mpnZE2W5OPyzw4OukSNN3kNDpzrZh+bW7wlyiEX
         YLpPxBtwae+XHfvcI6BOZu5FYLv0TlndMW1oTJdgT8UzCUH3fh0jyVzkjXdSo5s/kV4e
         +oZA==
X-Gm-Message-State: APuU4Z8fg4/aNLKc6OvhRAbyRgIu/EYPZzG6il4dJ5Rrz8G1fdIliFvT
	SKzHqWp2MTj0eaMYgz9KnTPROA1TxRacGgs/R/5qY0xq5pTeEkhY4Nu9hsgX8zXqirrJND+C5ys
	05l4iyXkbEM7EsHofFLHWm0tik+aXLKG1wI8B+u4zh62UX1WqRlXk2hzx7qfZG3QqR8MDMaSen9
	A=
X-Gm-Gg: AYBFou1nYnS5UrVUDe1vdMXLGyJMTqzcYabsuJSJN2AiDuQaWQVAoKc41z9a/XhcvQe
	ztldSI7LK4Daq4ZkOPeVwgL5qdyiNDVh4EfKzhYwYb3IYPmbdf+J7vjWRCHpE+kv/NBZfwJet64
	Vk9wQgELJGwfA7VGMVKhS5Y8OiYV8JWXeRFQAWhsaSSaOZ+I3TiSNyVBi2L8sxRivOd4hBDbHhG
	728aDcU6kkvHMdnZSGq+aV3wzzgoLcd4UzuGGBTWyH8veYvZx4mA6+nljqsedi+F06onfmTE3aO
	WVihDuvZ915/GvUwgafnm7/rSsqIURwOkmQNRMT5s3KXuzU/bFsvZz/RuEVTR2SR/K9NJ06JbW5
	dSrrvvlyl0ROKkYK/wmW80OIN9tJhDEx5OPOqW0mbiRM6Omln
X-Received: by 2002:a17:907:3d10:b0:c46:2987:2169 with SMTP id a640c23a62f3a-c510e345f4emr257884666b.24.1795009613195;
        Wed, 18 Nov 2026 05:46:53 -0800 (PST)
X-Received: by 2002:a17:907:3d10:b0:c46:2987:2169 with SMTP id a640c23a62f3a-c510e345f4emr257881666b.24.1795009612822;
        Wed, 18 Nov 2026 05:46:52 -0800 (PST)
Received: from [172.31.1.12] ([70.105.240.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510ca626f9sm96843066b.37.2026.11.18.05.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 05:46:51 -0800 (PST)
Message-ID: <f172891e-9e1a-4dac-8a31-17c13683dcdd@redhat.com>
Date: Wed, 18 Nov 2026 08:46:50 -0500
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-3.2.1 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is yet another mostly AI generated release
fixing vulnerabilities,,, but with two new commands
     * nfs-fh-verify
     * nfsd-iomode-advisor
both have man pages so take a look.

A number of mountd and statd changes as well,

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/3.2.1/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/3.2.1

The change log is in
https://www.kernel.org/pub/linux/utils/nfs-utils/3.2.1/3.2.1-Changelog
or
https://sourceforge.net/projects/nfs/files/nfs-utils/3.2.1/3.2.1-Changelog

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


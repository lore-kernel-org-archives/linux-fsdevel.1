Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F421638D
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775335433; cv=none; b=jSwKlASH3HFzPj8H8fPPSDOY7E7nd0HJF8BpdiUS/fIXR0ufXHXVL2Efj0UQ97ZAuchkGjdHS1M4qFpURC+Qz0VPasyemFTXcwjjHU75RdQzcafG0frWhvViNj+bXcFZiHDS55t+By5KiJGVqAyQX62fAhvp7MWQtTu59B2s6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775335433; c=relaxed/simple;
	bh=sr4upe7AA7Sopus3JvBlLh5PB1VI0KChYdy/WW84TDw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ua6K8erOMwzsQUOM2Y8FYxrOeXJmh8RpxBvY7fvP6qYGk1aMeY2x3zfCzfzkPvk+wFbC8QgA2QbQkR9ugynPdxIR6JAJwYEKCuwcnh8YsQ7R1oXR6JEZIko88fO9XIgy4xuZ0XzPOAZ3g430espW5Ox1DKYgQVDu3fteq7pVgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyEdmEE4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5MMdvEi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyEdmEE4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5MMdvEi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775335430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omT8BHjduDq2RjBJEv0I5JFb2p3Z5Pk34ClV94YmHRU=;
	b=ZyEdmEE4qpHF0AoScT3CkjmW/qJ0nQAfXDdiPDK73TCy27BiePle7i7i+VKYdxeRQ4lW1p
	YmHeAnOF1XfyiF+OfjO62oW/kPbVmPhiPmTR4JdxmO2gbhGYikT5E9VNHSHRQ7AYqpAHQC
	Op0bBDWxF6YyNS/Phc/rHfJbL7OTFls=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-_FlqW_6mMv-QyMphD-4yCg-1; Sat, 04 Apr 2026 16:43:49 -0400
X-MC-Unique: _FlqW_6mMv-QyMphD-4yCg-1
X-Mimecast-MFC-AGG-ID: _FlqW_6mMv-QyMphD-4yCg_1775335429
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8a4c1c022eeso101915456d6.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Apr 2026 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775335429; x=1775940229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omT8BHjduDq2RjBJEv0I5JFb2p3Z5Pk34ClV94YmHRU=;
        b=d5MMdvEihd7dvlXqfmumrdNr1YZ0JDBFs+N1Os/+2o9W9HcDdfTCcYlAw1DDMXho6I
         7oSw+YIviviOwZeBcSfLVAiXdXUUtPw3TH4XrsdDKsObsjynzyFnRsWd3QCdHJ7JK+yG
         ldKqljg/SZG0XFsZMhBoUx5D+ZEqdRIQLP0dthYY+NtPCZd7tfACrzXIUqz3o0VjxTFz
         po/90QABGTZI7B0HfZ9OSKyqal6399Jtx8rKFOYJJq1I95WzMOD+fb3sC8ZztdEikV+S
         dNB5Ga5dg0oqZFqhmCXWG9gnvTdEWoMPlIPYW8S0pvlyQTSzcqjUDBa5uAy20j9SPkzp
         nFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775335429; x=1775940229;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omT8BHjduDq2RjBJEv0I5JFb2p3Z5Pk34ClV94YmHRU=;
        b=s1GG33SH62V5SjxwOc3lAQRFGbbBkAY5W/TYbMbYbMDsJq8fZK9kZAbyGLjDGGfU1b
         30kwD/krKLdFbIrTf834Qnjc26BpAXgryvqUhc2KV972GjD0ntPG4hZOIwQxFS9zbevM
         4qAE9o5rUYu5uskuBQJx3UU/adean8erk3U0U1uYPYulWLmhNQTJVqb2YKeZSK0o9JUF
         Cw3FI5x+exaYQqfJx8LXAvErWitXTNoATtsuBKCAKqckIdVrLw2WbN1c2tiomzCuW0rb
         2HPuXzDNEEMDFghfqhkKaJ3zqP7niCcqmQKYjS7ZFozS/SiEzgodlUXlbYRhciPxtZnr
         vR4g==
X-Gm-Message-State: AOJu0Yw4Sg6/IeWERu6QTYcCe7aoMlTxYA50P9H+xNsraXprf43l1uF5
	857kFrsu06BJbNB3OjEp2q9WF7sQj7ByuNFyaie9gUoCaEeMlMntOt0yFjs8A0F9MZJC/8WJ+T3
	lys+gobv/jKmBWEwrVusA/sRVNdBQ+UD2mGfcY9IwuTZcUynGj2ryuUBkFFUzPxrv6WU=
X-Gm-Gg: AeBDieujI0YV/kgCzSdYDvlSImPKRzWe1LB/OIuMm3mC+XkxaxjQxF8azYroALOZxmn
	lsxcCIGjk0GxhvvLu749fQI4JPv5lnCSB0DLRg1l65b96DnzZJaT69WhBrSK7wAn/B0pWI3xPx9
	8/40QPtfG5uiMxErQxQ6NRHN98F0p3C97MwzPF26AImz3Vo0kjpyXPC53BIgS0XOs5HBaaNrA1E
	EMCpddkJ2pDw2eDxfD0TwhTF3aGGTXThIepemvYbyNeW7zVNipgzLMZepszBX/IZ66hS/aNt0yt
	LogZIhmzAVB8CnquEjwlrVHFVBxQm9q3tHV31Ni7ho+I9zTYmdOYlCOIlWLhqc4Ca6NSdRasBTL
	WlduTH4blELEtOB2nYT0lbg==
X-Received: by 2002:a05:6214:5f0f:b0:89c:da2b:4903 with SMTP id 6a1803df08f44-8a7048cb0d9mr136634876d6.46.1775335428870;
        Sat, 04 Apr 2026 13:43:48 -0700 (PDT)
X-Received: by 2002:a05:6214:5f0f:b0:89c:da2b:4903 with SMTP id 6a1803df08f44-8a7048cb0d9mr136634666d6.46.1775335428297;
        Sat, 04 Apr 2026 13:43:48 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.250.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5976e223dsm95438116d6.45.2026.04.04.13.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 13:43:47 -0700 (PDT)
Message-ID: <955a922e-c12d-435b-a698-caf73312f01d@redhat.com>
Date: Sat, 4 Apr 2026 16:43:46 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.9.1 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This release contains a minor version being disabled
(which is why the minor release was bumped),
new features and a bug fix:

     * V4.0 is turned off on the servery by default
     * netlinx is now used for upcalls in exportfs, exportd, mountd
     * signed filehandle support was added.
     * nfsdctl now checks for listeners before starting.


The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.9.1/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.9.1

The change log is in
https://www.kernel.org/pub/linux/utils/nfs-utils/2.9.1/2.9.1-Changelog
or
https://sourceforge.net/projects/nfs/files/nfs-utils/2.9.1/2.9.1-Changelog

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


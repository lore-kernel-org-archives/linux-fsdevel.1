Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5B53546DC
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728761; cv=pass; b=UrvILpDzAZDGFLsl423cozVBvhGzifV9ucD5PvKcOlxErCRhSTuySqC7DzfE0eZeQCgUfhtsznhu983AgAvSE4Hw7/g/RyF53f6a26bJZ5pvhpBBSFpeQUjE6Eb0ghQHFzk6uhXusHj/r9l708fz/+a3UtghTUi0xoBqEkWhoG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728761; c=relaxed/simple;
	bh=l8OyTHPsSiXlV3Gjth/iDTYvVrHiTPTknws/b6slKyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NW6TZgyjYoUV5+SMbuKGLyVdb60zWzfAwl9b/n4eOIC/nwIL71X4Kz7h8yoTLH8lKPmG1zb81y+wfe4p+3kPvXKvFB04zycMja23VHGtiJi7z4V0/vvDnwFiczuWArEUvqRhZG4zf2X2fAXLdES/K3GggivFR+MkDSluTj2HSFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IRDA8cgu; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IRDA8cgu"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c21495722so88889131cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 06:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784728758; cv=none;
        d=google.com; s=arc-20260327;
        b=lGq4NrunjKPELE20uOYqS7gRzkKAkw81m9KN1cvGvpiOchaJ3G932bWClYzJXIRdlg
         cDbqhwwL++9mhXjsB9lGGlN5Ad26ZD9Rn5tlwSeOCiCxDWiSZLe+Hn5KdUUPdqJ1UJNN
         48LCUmZ+OImiSZXAAXZ8Y90Ivnht9vGBMD0nldcOoznFEWsnpKl392MR/Tf9TFZ/mA+E
         /eN6DRhd7yuZCj245gex9FZHbCOMirw/AjVpmGAp5dJOT2yxNaCxMVEyPfVgq7KkNMpi
         rdwDu0D3er/JnrJjdSWvGP/YejYBFJOg28+YyCMlTeckn+eJs3Td0E5eeHeRanjU3G35
         ScPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vQ2/EjZAmPdGp5icD1VFPQXMQudnf/IhCWBft3t6T2U=;
        fh=vdl9lo0n5aHE9Q9iBSygaUabvwMPRK7YkCPss3fdlk8=;
        b=XO6mKHZUbS12V3qSXAT8WZBIV7oM1cblJrFeKNaOAr8C/9mzc19ip6BjhbGZNzZckS
         QpbWjn8wrLm/WiHrXt1GJKbjlIn1T9NEDf3+ISRL0YGFIo1xIsYsA2vgkssMdKVjRuwv
         dVDf4QsyViESwTExjRVAbTjhtdDFHmZa1RoD4NT6QWmx7HojVF+a3Dhl+JBa3tVLix/W
         MGjsaLPhLvaCo+eeJw7Nv7fOIex2EQMXPWsjDTOKgevuQjmD+vFIo0BkfsuZXHDDSt5J
         aOE36e6+Rq3crIFCz6PtEPFcYYmqUpNsu8CUjDp5AtF6t/WqN1Qq1LlaPvpvdBeW4d7h
         tA3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784728758; x=1785333558; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQ2/EjZAmPdGp5icD1VFPQXMQudnf/IhCWBft3t6T2U=;
        b=IRDA8cguHMO2QzhU7NBs3YGsQgtYSQxWG7i9N1JAl1eUNlB9Q4IO2o01XqKibODgRO
         py+0DFOuMegMt9DXMmoo4OT+xXhqdAQDdx/0+U5Zav71E4OC3VRpjAoQmE4+UR15wZ/2
         BzkE0lhRBahs2Rpn/+gnSpzjCNXuQjaFihV1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728758; x=1785333558;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vQ2/EjZAmPdGp5icD1VFPQXMQudnf/IhCWBft3t6T2U=;
        b=ZxWSYcNARcxwT+NIkIW8KnJobO6vKHhxm/M7JYf5o94o64e6CF3vzk/Jz4dDERcnz7
         2DE0kon4bgcEZlenl+s0iiCvlM/IboPkz8Krz5eR/HhT6RWTL2kMeBJKwCwxSY67/U4l
         aWAcrPwjQvgXrYGKb7O2NvtNCMMOdKxBjWCHjbyzTmtmgLLpc75+Ws7GFnJQ1MaHSg50
         1xVTATkgqsywU1xeG4FmpAGWLXVQfo9PnrGF8sVNsWaduNBJfVLpxLoOR8Rhj23cvdUM
         H5Kei0Mc6jsxFuTaDsyKUXIyXnciamQoxmsV5n99tcwKHGWN1NMqapr1Pj+eieIGfC9d
         JA9A==
X-Forwarded-Encrypted: i=1; AHgh+RqOIwxCGHgMq6odwx1fp8e89WzTTI6PABBMgaqbHxrbTWL+PCbEparag17+W3gMCWW60KWRC90eIIgVnBLE@vger.kernel.org
X-Gm-Message-State: AOJu0YxAEksMtREdHQ5eKr8VWzZRTP2yskTN06hV+d8fJVr9L+rMzg6e
	FhgIATEmGGtl9AbAGSk8W6/9cWYR15lOK3AxSvxt/D9oH8rrXEJ4ziRoOOo5cgKB3Ys7+T1uG+r
	BemJl9OMdTjVDrOvyXLZaBA9XH0L3Hqrd0olzORDtRw==
X-Gm-Gg: AR+sD13fcvh2fh+miilkpAYh9AWOB2C337EgZnoixwTYsByiEJhEt6c1mzuxlKVEcJ3
	g7a0l7NanM4o8WD8hLb4bhKbYBosXg3IHripYGWDZWAQ66I0aLYXQs0Y1N8O/3+3QMEhZb2lAZZ
	hYxgZstIoEMVJXkNYuMibCyV3DWTOhtj8N/pmXuhhoreIIaJ7caGUkNW3O0cS4dd3+C/3NUrS6R
	C3AdRB/eiTv5uiO+RDOxSX6Bhr0Nwn/STIuv8ETMTtfQpRYhaGUYPvz0uJxWCf7q3RaKYlpUPWY
	wLOhntESQX1TmS1nTQ==
X-Received: by 2002:ac8:5893:0:b0:51c:7b13:62f8 with SMTP id
 d75a77b69052e-5213eb800b4mr216533471cf.78.1784728758165; Wed, 22 Jul 2026
 06:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034541.68781-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <0100019f7da14ceb-fbd4edd7-ce17-4770-8c58-1296ad3e3fbe-000000@email.amazonses.com>
In-Reply-To: <0100019f7da14ceb-fbd4edd7-ce17-4770-8c58-1296ad3e3fbe-000000@email.amazonses.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jul 2026 15:59:07 +0200
X-Gm-Features: AUfX_mySW2J0tjX47cdgUqD8gQ_vf8pqX8_96NOWv8ZzqlVpdTk8edwifSp98Qg
Message-ID: <CAJfpeguf3EBgBrf=mrG2Jp=oNp65DDg1fZsdEaqgBn6UNNrZRg@mail.gmail.com>
Subject: Re: [PATCH V11 3/9] famfs_fuse: Plumb the GET_FMAP message/response
To: John Groves <john@jagalactic.com>
Cc: John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 at 05:45, John Groves <john@jagalactic.com> wrote:

> +       /*
> +        * The fmap size is not known in advance. Start with a modest buffer and,
> +        * if the server reports (via the returned header's fmap_size) that the
> +        * whole fmap did not fit, reallocate exactly that size and retry once.
> +        * The server learns our buffer size from the request's
> +        * fuse_getxattr_in.size (GETXATTR-style size probe).

No need to retry.  I'll post a patch to dynamically allocate the reply
buffer (already posted as part of fusex).

> +        */
> +       for (attempt = 0; ; attempt++) {
> +               struct fuse_getxattr_in in = { .size = bufsize };
> +               struct fuse_famfs_fmap_header *fmh;

This struct isn't defined until the next patch.

Thanks,
Miklos

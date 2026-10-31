Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793409817;
	b=q0gpjPvLWuRLBAbPDWC03MHFmcohqPlSIb4Hx49vCv6uIpqu9MEWwnoWSR9ESA82EO2U
	 bB/MhZhMtp9dV3iopoxgHMlNcIzwOMezf8fI6qHc6DVevbkIjx/pjN0qhkBx09RoErch0
	 OMZliRavChhN9siIjT8qQnHt3C35U1GVh1kbAfSqcJdNgJENWzSY0CyKPQka9w3hefkT9
	 AYUgDVHckRxTHQzR1+Mt0yXa0mh571PXA40he21quAbcQCxRZr/iBPpzINV0d/v3ol6IU
	 ZVW+6fJ3Rq6/5rMmQhzOpMY9BtfQ0pAItdd2ljR3ZMRz8nwdom0cq0T9ZK/T+m/23xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793409817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6nKy42afFVXtc1pmf+02i77MnNtiH68dE+UHRbcYHP4=;
	b=Mnqz9goMVjcB7Bzb2vJO+pJFMBh3hJZ8LtALKfLCWBxX359xz3/6ubJhNoCWe/3wXfat
	 z4/aqY/riHMHrKuBW1/fm3ZqZ8GmcCpCB8+PFD+B9noR583r2YaG6o3x0QOw69P+x2dqx
	 CaYKXxkQ77FjV0iacTS3xH5V8kI7Dt1SIlRYLAyayy2F0HOHn6Z370Rn7fMvRtuDjxXYB
	 sRZu1+xUgK6ksd2Y0AtlHO7oEWIYndQYl/xioTTPdf9gp1eoILwXXUHREMtE16j5KvlZQ
	 kxhLPdv0NaddjrvcuDDZ+gnjYvTVd/Z/HDYTesXYY3q39oE+Un5lGH3DjP1We0n4gaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d0NblGy2;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5F606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 01:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF5F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d0NblGy2
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so2223926eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 18:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793409816; x=1794014616; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6nKy42afFVXtc1pmf+02i77MnNtiH68dE+UHRbcYHP4=;
        b=d0NblGy2IsRhO34Y7hO7u7yOI+pl2kbpMI3OrB3LQIBKfZ5bePXrUzAms7mvg//bUc
         Vk+FpwQtD5TYY6prFAg6SYanxBQm/YJ2Xoi4pzkmb6UNA/mHfKW+sqWD8RctXoyDhIXm
         RzUawgosSZnougVC1cQvz208uFRNITZ5gcJa5DhCIQXKAfstvOPIhKNdD3IWjZkv6vdl
         DTYdW0otw6PH8+G6v/nFrg3pfYUViNKD9AQIHGKlzXZP9Pa9znosTHDn5jtj74EOhkeI
         auSb0OPy6pCojvDKL3e2VfaMUaG1vSK45UV5mkLRQF6OPvlMjcXHEinDbnYLW5uUI2xV
         JFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793409816; x=1794014616;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nKy42afFVXtc1pmf+02i77MnNtiH68dE+UHRbcYHP4=;
        b=EOjqls7yT1OlT6T8Wp1uRPdLldV3yqiM5QLp0znrtyqwncwJw2NKkQgQ7mwERk+SiJ
         lSbYO98oT/z/IrWUhUd4eipoHH0R1NEtL0YqjGptwmVDMp09cGPHNrFkm5P/oLhSHPUy
         Vlyn0tZgNs2Z0l5rdBQf8suLczUpvaACKNrDpmWPFqTMipQC32ipXpN2snkdijq0h2Kd
         HXBzq9icCzD38onBkuaKRANyjyAIIGYvcFjNfc+yaSy3wBQgiPmPVFGuYKQf4168lYe0
         A6wGZS8i5adVjZo6VVAa1yxkrs9Sw3ktlk5jzb/kEEaw892dePIIets2NKKO0DzcIxLy
         3kqQ==
X-Gm-Message-State: AFq9FYJdYJvXZylrkXtyq/NLR6ha+4jN1t2A+CWoJa2MMQelp08djWZn
	rpW8TPUUTwamUsqyj2nQ3s503oyzetHowpGcma3z00EuMarpPexuoZXF
X-Gm-Gg: AYBFou3WOuU1CKdOdoM27dT0kLh504twQscyicBRhGfFebaK3PzIa1Kv8EfZlE8l0J+
	KxxuA0Y33xJrtU9KLO4mZLEaQCSsY4rknjXq2que9EXeB05nUtpBkMsSBoBAWRDPHBHww3jI3Mn
	Ugpb9KxwcOOoY8i9wgB0RF4/4InwYWNJk+HbBozJDVPIW8DleBt8UIEjpRkLeSUpuG/eFJBiQDk
	SKWnApRrK7HD+miYaKx0CtuVjqjN4lG23gnAbGCV2vNR2wXJSKuFsYcFg60ONMxXlvU/ENP0NgO
	7sA65UEfNBmNmiODfmdfPLWZs8/Qjaox1pf+F9JJ6I8OalSsasswxQC7b5ZMOZHoV9aqI3SaOpz
	hDHK9+Tg2OtSQaHFWuUZoNIwNLAIUGniZYnPEn7LI/Pm2UyEl8jb1Ykc3tVTVuBhCNxejYzPrgx
	NN6UB+B/36whzMBAMEEkulE5EgEgENFQclE541fvMxoZ/0Uy/WSNcRZKlvoI1F4iFzMeHMZxp9n
	mbsDpA/fpJY1NPjVTPAdMISQuWoYOQ61n7ZdXnjD0uqhxT6yekt6oXmLZXzsV6c+oti6eOcAZPA
	UPxCigF2HkFqR0jyovWQNmGu3N5W2yY7tfHmbY2SF1ptq5WmWIXt+dFcMGrefQIEVDI3hBhjVeI
	W00JR1nZsgSXKb/4+i1RoFvCvDEIg
X-Received: by 2002:a05:693c:835c:20b0:36a:30b:5dc0 with SMTP id 5a478bee46e88-36a423c338dmr5639993eec.24.1793409815876;
        Fri, 30 Oct 2026 18:23:35 -0700 (PDT)
Received: from macbook-pro-de-joas.local ([2804:7f0:b101:c5e8:f804:4efd:32bc:71d3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6eabbsm11924617eec.24.2026.10.30.18.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 18:23:35 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, slava@dubeyko.com,
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Subject: Re: [PATCH v7] hfsplus: fix null-ptr-deref by creating hidden dir on
 remount rw
Date: Fri, 30 Oct 2026 22:23:32 -0300
Message-ID: <179340981245.8403.4135841764755575334@gmail.com>
In-Reply-To: <20260717135706.42918-1-kartikey406@gmail.com>
References: <20260717135706.42918-1-kartikey406@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 17 Jul 2026 19:27:06 +0530, Deepanshu Kartikey wrote:
> hfsplus_reconfigure() does not create the hidden directory when
> remounting from read-only to read-write, leaving sbi->hidden_dir
> as NULL.

I independently reproduced the syzbot null-ptr-deref and confirm the
root cause: on a read-only mount of a volume whose on-disk "HFS+ Private
Data" directory is absent, sbi->hidden_dir stays NULL (it is created
only in hfsplus_fill_super() under !sb_rdonly). After a remount,rw,
hfsplus_unlink() -> hfsplus_cat_write_inode(sbi->hidden_dir) dereferences
the NULL inode (inode->i_sb) during rename -- the reported crash in the
[0x28-0x2f] range.

I applied v7 on c339f4010 and tested on arm64 with KASAN, using the
crafted image from the syzbot reproducer and the equivalent sequence
(mount -o ro -> mount -o remount,rw -> rename): without the patch this
oopses in hfsplus_cat_write_inode; with v7 the remount,rw creates the
hidden directory, the rename succeeds, and the KASAN splat is gone. A
normal read-write mount + rename is unaffected.

Tested-by: Joas Antonio dos Santos <joasantonio108@gmail.com>

Thanks,
Joas

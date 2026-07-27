Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E3538A73B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164298; cv=none; b=Lbqz3UMs2YE9zQTaLNAq4YSnT1iHMKGsR6WJKr54eicTCXSzp6W6QduKlx1dIYA7FsB0MExlphYbBtGwCpy3kb/PsMyG/gVGexFRdXqJrjUcUdkjwVooxX1uTMZg5XhDHGLFp9VWELkBU3QsYdpu+hG9VAY4kmHbfxI9FC1rJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164298; c=relaxed/simple;
	bh=/pHEhqhHim6zbvXlXGSytIteuWLfY5Kr9gwBWC8fFio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjuW+99uEnggCvVVNP7MWOWWwnScKqboQ3ATpqsmVftljFpHEZt8WysaMgS+RT0INucsT+ZEfGvgcRiMhE9X05xbJ2fvZmYZ8/psG/GuikpmCQ/aY4Ru4O+DK6AYxUUnYyUnGf8JG8kP29Vixi7imoeM8PCQdfRYEPrnQ7oRVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WtIrJspU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WtIrJspU"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954dff6536so20797895e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785164294; x=1785769094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
        b=WtIrJspUFDv9uYL8E4OhCURfnCutsSkbOm+juL/6yCshO8FMCiFZrYMSEpcfsdW4Nh
         iKdHsW3hXXVC8Pl4kUTysqT9Zr8oF1RzlXcRzFSGc2UBRbewwmpIc4cUdB8jmp3pl1An
         f6O93wZ1uT86BMhjp0hkFyCYKEgWqWi968vQRJXARDoAz7+tu8TEFguRFWLq/na2hZxb
         h+/lKgJgJ7KvEmuOlPlx1TgAEAOP3gxpUS2jY/c4WBF4cEndQhBSKAsMyUFZVAH/YqQT
         oXvZ+5VFrjrP5i1FIj+Vs0SajlFsW+dWgVvOzDcsFpUW8FB2tzSLDDUFkca3REdCvM53
         ZAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164294; x=1785769094;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
        b=H5mlfCCG5pLfqzWXFMujaozbRj8eCGWKHe8sjCREB6hsS17NmqAHztUgh3oSpZtS5i
         hg8zgzpMt1fchzXtkfgdcOMXGzqvJIkCnwOulG2zbZLwm1vDlmJ+vPUyzuohvNvNFDB1
         UJei9DoHgRCaURkX2LgDQowyRQ25gyg0SzG+VnFA9mR00sBrgedg/srjY7DalEFbsq4J
         CfzGRNWPgVXI3vNFLViV75jJK0NX0fgrXSj16mykboI8BjZI+12UJ95+FwixZviMFE8+
         5BxH7rXAyJLwjok7m/spqnDo84Yz7h7dk3TESDiQ8HbPPbYcx+VkPQfVRf9R0Esr99eV
         aW5w==
X-Forwarded-Encrypted: i=1; AHgh+RrLoBLbHRS6LdM1LEHr/H0LMxN02yRKSkonO8fXlVJdDm8YJkyggGq5f8h1IxCQwrDgzfRid3sFG4uZMan8@vger.kernel.org
X-Gm-Message-State: AOJu0YxMi36RljXuyheZad0BXo7a7tRw8ueKp/4N29kfXEonzV8spPGA
	s32+swJa6SbX3V4pT+kaWtRbd+sMQaRdrfekDx2Xlwe9DJiZdLuhCeCNkhImvkOmhEU=
X-Gm-Gg: AR+sD12T9Y/nVYRg66KXysIqSpMGbWvir5vFU2CViiNWElYRe4gny3cJkcjAW68SeZ1
	jfZNUxUx6Ab1VMJQ4m8aLlkQUksykA3fGWI2lTmaTWK+SicSfVohuTURTl9pVnROG7k2GACr90L
	4mtJvzjv5R0K7J4Y4+RM+aDTmVq6Rfx+0hYtDjGt+A3LTYkcacv1V1T3Vp4qbEykP34n/N1c/Q5
	41LliUxLkPEkID1u2ijBXrIpJeY/Je1a3BCXHOXD44Cdmm9z9YyCRu+y339puaSCTgXeRK/Qfdd
	7Tk3C8hrmFHGvid+hIgc1bDNX2ArBYKNBAv2simbgpGE8Kl9+saLabF7eXi2/QHkTsqGgrib7dW
	sy4AFoycbM47F23q+hq+XZZjkP9PTbA2P+wgIWzrtdQjN7/L4b67hL8gYQk0zZVa9ZhTKy704FW
	BzIoa/5l12QCW4R5vYQ1fZiaB5QyJ8JZwdNFZ5itQ=
X-Received: by 2002:a05:600c:1553:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-496b5731987mr114339235e9.39.1785164294020;
        Mon, 27 Jul 2026 07:58:14 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee0e91sm231594995e9.4.2026.07.27.07.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:58:13 -0700 (PDT)
Message-ID: <ead73f81-26ef-4a46-9ad8-fcd2915563e1@suse.com>
Date: Mon, 27 Jul 2026 16:58:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] time/jiffies: Include linux/sysctl.h for
 proc_int_u2k_conv_uop(), ...
To: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260721131207.803760-1-petr.pavlu@suse.com>
 <20260721131207.803760-3-petr.pavlu@suse.com> <874ihmke0k.ffs@fw13>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <874ihmke0k.ffs@fw13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 10:31 PM, Thomas Gleixner wrote:
> On Tue, Jul 21 2026 at 15:11, Petr Pavlu wrote:
> 
>> The kernel/time/jiffies.c file uses proc_int_u2k_conv_uop(),
> 
> jiffies.c uses ...
> 
>> proc_int_k2u_conv_kop(), proc_int_conv(), proc_dointvec_conv() and
>> proc_doulongvec_minmax_conv(), which are declared in linux/sysctl.h. It
>> currently relies on this header being included indirectly through
>> linux/module.h -> linux/kmod.h. Add the missing include in preparation for
>> removing the linux/sysctl.h include from linux/kmod.h.
> 
> Can you please split that spaghetti sentence into paragraphs?
> 
> https://docs.kernel.org/process/maintainer-tip.html#changelog

I will update it to:

    jiffies.c uses proc_int_u2k_conv_uop(), proc_int_k2u_conv_kop(),
    proc_int_conv(), proc_dointvec_conv() and proc_doulongvec_minmax_conv(),
    which are declared in linux/sysctl.h. It currently gets that header
    indirectly through linux/module.h -> linux/kmod.h, but the latter no longer
    needs to include linux/sysctl.h.

    Include linux/sysctl.h directly in jiffies.c ahead of removing the
    unnecessary include from linux/kmod.h.

> 
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> Other than that.
> 
> Acked-by: Thomas Gleixner <tglx@kernel.org>

-- 
Thanks,
Petr

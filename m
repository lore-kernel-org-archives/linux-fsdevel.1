Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01636405C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355085; cv=pass; b=rqRY/ynj/dQ70JCj9Khy6sjeXsF5qtSDZAqgSmQasgXPUYOWseG1ewWqs7go7EusPNxoLSsJg/KUXJ92dF5BF2HZh5Ay4QaI7u4lfPXDOeZcECQwWRBO/5lLRcDgG8ryxXv8k5DfsOQuM0OHXRuAwg07Eopu1OVsgJbUY9yviV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355085; c=relaxed/simple;
	bh=vwnfSdJLdKaz9ZvYKHUKW6o9hMPAY38OWs/+ezdVxbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7C3LAIZKEHCkqHMCv/vXL2pJpZMKrmY0UgWX0E71cJNKcm17QXxWirVRZG4/9hcAwo2i17tsmYEDltGoSqkobdDLIu+XpC6AFBvty1igtoqz9OXMnXIsjvsDqzw9rj4Yal2qCECgqyclG+VdpWXi8giW9fsMCCMVcb3Bad7whM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W38zozNq; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W38zozNq"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bda62f13d90so372335666b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 02:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779355075; cv=none;
        d=google.com; s=arc-20240605;
        b=KjdNUsIxMvhZ4BaLyWr4r6bCo8S21mQEeJ3wLE98Z7B32FqA/bx7IjRCWMqXdTs60M
         BMVAdSW92J1k9q9kyrZh6DfXSJo1jkQYS74Qy8WH+B0aw0EtkJTIvhSeEUfPqIYassnQ
         KM3zS+klkjnvGkvYR8mh6IDbgn+BNcFtt7i/vlXK3Stdj42DRWCM1rKvl7mb7iI1Kr9u
         NRwgDXtjYRiVODvwwAYGgz7WqO2xlpqV9sCtx6rECB5Z/IwbVRb6YbCeUckbNZhKatSK
         7lOrCdk8kHwLluojSX4DonhJjIHCJ9hT80tpHL8/KrC9/IreA4sZ25McyCqRyq/nR5wZ
         5iFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dz3+FDOFPvj/C8tgF4g8dO7NJ50HOG7kSmIeflMib8c=;
        fh=GWCkUYOwv/pRNcqkv+HWLO+67if7TLpcsOqlaMmUa6U=;
        b=lKsjWVz8ObB9sbsBjMXyhCiWatCak67NQe+ALGItO2Lcoj8+ybehsgimnsz5aVzSVC
         eu6QWI/zgMTHi+uHr0217dZ6FxUtGAsCr9E6xEJC7IIxdT4pTUE0ZDin68xFPrbfUmSI
         E0bRg52bLA9Ov06NX+4qjIaEbr/2IzcPYKYOYOJST3T86xjEuH58Nt6QwJ+at/L0/Xe+
         erKhrVDeCbUmJcHF9o3qv4Mfu5U4YuUjJcckG98h4hdC0lRugIKzC5wtQV/mgC5WCh6j
         b5La5kQpvaEqpX0JWAF2AV+q3mzEzGB/4PLMWtxO2r4ZW+fakTJnxG2VirCzZXyQzOSi
         LPvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779355075; x=1779959875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz3+FDOFPvj/C8tgF4g8dO7NJ50HOG7kSmIeflMib8c=;
        b=W38zozNqryrQLJ38gOwf/d0E780psCsJOvIl9E5WXWCDipJqX5W16rdQBmdLQrBJmN
         0jIDMBrzaG4gP7SMBbJyd3IKKebaHo9sUm2c1nxdO1jmAATIgNFH2xam6+7UGFj6Osir
         /XRD4uw/oaBWaQ4EFDbSETcDga4Zcdk5DH8lf6GemUJF9Toaf2iFjiSAEJutnDkj52hI
         QzlPtMJsVH7AZeeD7xlvFvBasUMsnHNBx2xtNIU5XKNSIo0gKibYCuHUwEBD5w/x7gb1
         Xl6AW7/GTXXal4ATgzEkSKqASEQ5iraRHqxSgzT/67NzCn2sv9Bl977gz4fLwjygum+c
         Rchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779355075; x=1779959875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dz3+FDOFPvj/C8tgF4g8dO7NJ50HOG7kSmIeflMib8c=;
        b=dHzedUOP9Qj1NvzC9narIMvoX/yJyupnzug0i0IZt2+T5x5Gt7W5QDEVavzjpYi+Z+
         Hkv3pw9Pnf/dx3pKIUwcmr8GW6Tp0tmSePnFNzhkAMIKDeRtRt7VZup6PI/qWhqw4L2p
         LCmdM/kPLwzMgBi9dCDOlhX54Hqb5jtFQnSGFVDWdsqXOBRhCQOSK1e6HpcMa88ZSf73
         DdGomNDneYhXP5IXAFrJshBtYUT2qYzbGuPNPX16hL5bNuC5nZiqGUMP0DncqqUrRylR
         V8nF3YS3uZZCGurzaK+nzssLiy5SeWJ7Uhb0o0c0x3kFhkaly9ofIQUYFgufCXRabhy5
         QQHw==
X-Forwarded-Encrypted: i=1; AFNElJ+5fc+YKzs+/m9n+8bXcuJ1rulJUzpleLDOkiAePUau2YMhf7DnTAFLJj9eepQwqGKvSQ1bz31gpjy/Y6G2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39ZTJfxH4CivTdE5ZgHxZ3l0P6LnlbIevF/M6z30d89bh7nbW
	owxQdCcu2Bz5bFaLLhGRM8ON0pJ9AfsXcFi1GVHL1S/3pGeN6wnhr+7vK84cGDHW2c/oKPlpv59
	XpMuAgeWjzyfwuEoVQWx6cw4u0urU0H8=
X-Gm-Gg: Acq92OEjywNiQWut4WTBeqnHVjJn+PMrY2UYbmCcD/AcuHCfGsBifgRvYaYRFfkS/hK
	fZOts8FlyXbT0o4Xv/voocfvNpe07ywQs3e0Mor6Fx724fx/CvLkaFTue70xiAQqMcqdZ8bgsOE
	MR/Sp5wgv7wdROjrJ8GKFeZFKPYGcpqOW6eNP1aUoDR8am4u82+cDD40BQJ8qEKZ0NqcE5uA9Ve
	WJaEIGQcS3UUq5Xof5R/jyV0aBfUE1Ak+g9PpKue3qXHVge6OTm64WJth6+quqOzYNRULc4oxRq
	+FEdJzxf4eG6Vku23+hvUIgyhXmJfdkj5npBIio=
X-Received: by 2002:a17:907:c706:b0:bd6:6f5e:ea6f with SMTP id
 a640c23a62f3a-bdc12f8ce8bmr110244466b.19.1779355074839; Thu, 21 May 2026
 02:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520225245.2962-1-spasswolf@web.de> <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <20260521090835.hz0aIRaQ@linutronix.de>
In-Reply-To: <20260521090835.hz0aIRaQ@linutronix.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 11:17:43 +0200
X-Gm-Features: AVHnY4KUqUzhgX_BVVTF4RDqMYY98JVjveuj779cZ0EwzI7KynJ8upkWRPUw0Ic
Message-ID: <CAGudoHH0UHvLapX-DhLR=UGv+E6LwjPA28mdSgZydrnsqQw3wA@mail.gmail.com>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:08=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-05-21 10:53:03 [+0200], Mateusz Guzik wrote:
> > them in place, but when I was rebasing on top of the RCU-ifing commit I
> > figured I'm going to do guard/scoped_guard in there as well. Later it
> > started failing as the compiler did not like goto retry out of a scoped
> > guard area and the unlocks did not come back.
>
> futex_hash_allocate() has a scoped_guard a goto to again. In case it
> helps.
>

Huh, now I slapped the following for testing purposes and it compiles:
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..d21d264672c5 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -282,7 +282,7 @@ static __cold noinline int regen_filesystems_string(voi=
d)
        new->len =3D newlen;
        new->string[newlen] =3D '\0';

-       spin_lock(&file_systems_lock);
+       scoped_guard(spinlock, &file_systems_lock) {
        old =3D file_systems_string;

        /*
@@ -320,7 +320,6 @@ static __cold noinline int regen_filesystems_string(voi=
d)
                 * Should never happen of course, keep this in case
someone changes string
                 * generation above and messes it up.
                 */
-               spin_unlock(&file_systems_lock);
                if (old)
                        kfree_rcu(old, rcu);
                return -EINVAL;
@@ -330,7 +329,7 @@ static __cold noinline int regen_filesystems_string(voi=
d)
         * Paired with consume fence in READ_ONCE() in filesystems_proc_sho=
w()
         */
        smp_store_release(&file_systems_string, new);
-       spin_unlock(&file_systems_lock);
+       }
        if (old)
                kfree_rcu(old, rcu);
        return 0;

curious, but ultimately does not matter. I think the current code is a
little better without the guard stuff in this particular place due to
kfree calls.

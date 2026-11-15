Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794756485;
	b=g45qCnMmlLM1CPsGG/tlnlUwmMqyuHQOQH7yPoUHdapZncHuXZaEMTmaqlU/iOucGtiD
	 AlugZqI79kJS3AndNPs2Y7xT8/ZlyeZdr/BDiUYWHCkz3zoLWZ7qXShdD3WNJqQ3GEFS3
	 /CZ/ViSOy2ozGuArdQfRmMHcK8VpBgQ0f4QzlS1eOtu+xZ+6ErBm28pCRuMn34QgrMhK+
	 nBphIKNoN7h58tKL7fRbI9yzWvGiYJkfvQ6osbbNBAiKCS3tqLVI0wnndxIYCwve/ve4r
	 4FTQYzvzk/FjSQo18XA6FVFmkhhyeRI9zCGBnq7BdLmnhMKe9nt0wR0DSCjUJtdLJAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xUMcU5qK7kSB0NoODzS3a0bfU4PtI4V1wRd11kTwtDQ=;
	b=eVPVJbA1MU+CbYWy1T/eXZP3iuHkm2DEroRXP7NHuAQskBZoMVMa3mSFKiNpju/VCgfa
	 pWp2Sg2cFvuK+eRWT8Ug8nRhzuocDoQ/QyVkomudnEBrdb6o2NLk6zP7+XhanEwK4O1wQ
	 MoxJQUQ9NrE22U0Z43NBIyX13ivTNyt5LgAB4a74IHQ0vGRghVhxC6wVjepu19gxr9x6s
	 82rRaK+kh5xjt6NJ0juKOPhs/9CQ35oTag5jxLVraIh5vQy4x0gl+3zEtTplqujO+UzfM
	 RDcTKw+WvYMZA995YtKSvrFZNZyu3OSK32I9xSZ4wNAzB/Et9O0PTPVi8BtnRC1M15A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VftyWGcL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78FC606A323
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 15:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C78FC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VftyWGcL
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b807aab44fso488885a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 07:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794756483; cv=none;
        d=google.com; s=arc-20260327;
        b=O9yKNNh0QDHQ19BZMg0dxkblcM8wXiGDvFpKVmqHGbxbOeUHd8K7NbjiI/yoMPqraB
         hsqQblj/Q+XKrcKGiNkZ+iOLVgYchbA/cxGz4EXAmSyNscJjPdsFDwrXh+CWVSeth1yB
         ab23vwz02d8baLUIrzVcUQ4QfmBmp8YsJrj9bwB6nm4tgK5HhH5wTxhVzeZdweu6/ftP
         XeZdH2sARI3pP8ps4ztEoBsTrMdg56Bft1hYdRCcilWw4WORVvEBCQQy0RoYshjOEenD
         58SvV6UaZtHVegQur28Zfmaq5O3TAmS+XzjuaVsptIbDMZdkxGJ5TLZGFOFRfF4516xa
         Sj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xUMcU5qK7kSB0NoODzS3a0bfU4PtI4V1wRd11kTwtDQ=;
        fh=5vCLz6iCfz2xqAp/XNfuYX+ORsUNHwKR4JVdVMuPulY=;
        b=Uo9RvZOxXXZsZB4EJ6rJ0w3UoajGUqhJ8FAsmG+AUeNnNZiBv/EqCkqq4JZQzG0nss
         4FmJ8K0fAstYgky91NORGuty01zjLzCiwhi/2hen3VoqEL9EKihLPCB9R91QRsMSHtbe
         laBxQuXFz2jNGe73gLEJ+Std+RFbaMzojsrKo6tLenoFNiSTsj3pgQ2sw5SPpZE1+p/R
         7Q1uuNZdV5v2J0oivtIW4Oe7FU3BiQ9aJ28TsTyK0l+3q0AdlehoZCPziSD0vmRfX3MQ
         GKUcbae/PszkWi3KTkK6daa7KAADrrepdmCkeQHoOCa+cZgQt4bexlw0ZfVp9H8y6jpN
         D+Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794756483; x=1795361283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xUMcU5qK7kSB0NoODzS3a0bfU4PtI4V1wRd11kTwtDQ=;
        b=VftyWGcL9iff8xAJ3H+nxtwTRxLBkhTmGdR10PGzxaM+wVmPDR+/eDmMynXeabpaE0
         s8r6k0wPGzAFSZss/VYyVYAjv1Q2eJBtKnhcefhsTbsGB8en/SlHOfScb7HWhxnjNn6I
         +yNfBv81q/l8dv2y3BMJmpyJfdrdPr7GMZgEoW+7XFzYtbudxWEVohYv12ZVm7o90C2C
         uLtpswMb19GWZWhSsJKXvtoAUoHZZmSnuzV6pI+L9zcXlu/8kYl/4EMRt8hRGy5UMONR
         vDx6RmuyYqz8/+LZgK0anxC4d5KOPcJv87PZGJVJcwVN9Np9EEWcK4MGATx6ot2OjiBC
         11TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794756483; x=1795361283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xUMcU5qK7kSB0NoODzS3a0bfU4PtI4V1wRd11kTwtDQ=;
        b=GkGUvaf4C7XUPBNQvyEvEPH7DP1bT2nl0SP+H6rRXaI8F1Mg3Dr5PVQc3y8sqENFy8
         WXwRdGCsC1Spgf+ZrGzqAtcjAQYOW/a/zm7EyBhuDGnb/0xddUI401w+HEz8oOIKQ5Wl
         Pgi/zZtfAZ4Oc3DZx/lGaEkPqhCMlp4cfxHJg3lvHo9rTp3OGqsapaFMEj/4cjWGF01+
         Xro3AXOJwHQPaBRNTtRtp/xwwVG4rg5guRFqhVpu/pfJvgmRkn4gdrueAZu6ZfIAudV+
         grHMhvorTF4FWnPIaUZnmlbguDZHdb8dW448lyX1DjaUlR787fuLl6oPfQNEkFAI6zP/
         Zx/g==
X-Forwarded-Encrypted: i=1; AL+hErE/q/b+9S33Yp/eYgF/5SARgQYo9I93uoEKPoNEnOulv0s+qhuHLjswc+ukPAph0wt1ZliyG0njKGc1Pj0X@vger.kernel.org
X-Gm-Message-State: APuU4Z/i9wTsdcwnJeOE7+4Z3oswEs9PBGBekTkmxv1D+rx+Gyaq38EW
	hDWmMwGHh9hJREqUvMitghRQuxxAmxKqHt5sqUnVMR+BN4kmIi1yysqN4uOz9G4p7megTnSq+aN
	TWzYOV1hbgA+B2EDxgtfZF+1Rt+wAwkE=
X-Gm-Gg: AYBFou0abUNy8L4hpdrUWGBZBUn/0IveYzdz3W8sXeXtI6OogCdb5PJwOxuy3ntBuI8
	2H4sGkMT9RPjj3UxwU+dhxoqOdYaU1ZD5FLRW8RpmOLEARVQ17c/+0P6xz2COnBKWo0u6XG1eAK
	bAlCH16Q+AtMX6RDVjUJ3YvTE4Sne6nVkYOe77OX8sH6deo+H93tPbMdRsb04vDsQk8kVykCkwo
	Jfwu26dTv0SHN3jHqGRRFqizNdjjNhtL7R+DVW9q1L1Xgce3sUoPm2JsyTQ/29SRb7RXerCc9br
	KLDRlU/ZV6uWVey83NnmcFLRENBSVhVgwjqR3Mgbg60wQqgevo//RJhzXxZEVjOC52Z8fwqwUbE
	H49KlFeWky+U405Tc0H/xGbulJf09P+8tz5GOsO7dSjoxqr0XtAv89RuMaN7wff3lJ2P+xw==
X-Received: by 2002:a05:6402:2350:b0:6b8:50e:3bb0 with SMTP id
 4fb4d7f45d1cf-6b8050e40a8mr1455124a12.43.1794756483049; Sun, 15 Nov 2026
 07:28:03 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015143601.2095784-1-amir73il@gmail.com> <20261015143601.2095784-11-amir73il@gmail.com>
In-Reply-To: <20261015143601.2095784-11-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 16:27:52 +0100
X-Gm-Features: AclHuK8N0M_iWACjjiE88zm0Es2YKhOdn38LKIiSJRO2rgWxBl-Nuw0eWLNgYL4
Message-ID: <CAOQ4uxjz_bsCRG8iR5GpiB9OVUKzbcpQbGXi2MeHjnAfrUZzKQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] fanotify: introduce FAN_REPORT_MNTID
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:36=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> This fanotify_init() flag is similar to FAN_REPORT_MNT, but instead of
> enabling the legacy FAN_MNT_* events, it enabled the new FAN_NS_MNT_*
> events which also report the watcher type bits in event->mask.
>
> FAN_REPORT_MNT and FAN_REPORT_MNTID are mutually exclusive and therefore
> the group accepts either the legacy FAN_MNT_* events or the new
> FAN_NS_MNT_* events in fanotify_mark().
>

FYI, I used the opportunity of this FAN_REPORT_MNT V2 to fix something that
I found to be ugly in fdinfo:

        } else if (mark->connector->type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS) {
                struct mnt_namespace *mnt_ns =3D
fsnotify_conn_mntns(mark->connector);

-               seq_printf(m, "fanotify mnt_ns:%u mflags:%x mask:%x
ignored_mask:%x\n",
-                          mnt_ns->ns.inum, mflags, mark->mask,
mark->ignore_mask);
+               if (FAN_GROUP_FLAG(mark->group, FAN_REPORT_MNTID))
+                       seq_printf(m, "fanotify mnt_ns_id:%llu ",
+                                  mnt_ns->ns.ns_id);
+               else
+                       seq_printf(m, "fanotify mnt_ns:%u ", mnt_ns->ns.inu=
m);
+               seq_printf(m, "mflags:%x mask:%x ignored_mask:%x\n",
+                          mflags, mark->mask, mark->ignore_mask);
        }

pushed a new patch to fsnotify_group_type branch on my github.

Thanks,
Amir.

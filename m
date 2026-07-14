Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11213630B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023764; cv=none; b=oUkiXYFddzKQz3ODDh8TWwgSW2Ot51vPEsHUNAakX9O8EpAMMjQVUo5jHEUSq6u41aQfiObvFC2eSMA0tVpmUEHuJ7cWUIz2n58YDXK0PQSAGeub0idWkKCcUZw729vpE7up+0suEZ18KEJhijKoblsPVganCafFiFY3dPcOhrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023764; c=relaxed/simple;
	bh=DScqINsgIXlOJrEHRD9F6lR1ra3KG+IyFe5aUHv4mhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aamhj6h2S44ZXljNG6ovcDyYVSuDbO/Yq9kVn/3pfynm5iUXJaYWFWoYGXKAQrzNANPXPTj3fnAkoUCV3vbSx0bAlYcbsErsDTaADZseuZxYfn1X70cMR4bmjUR0OPqmuDT6MosZpgOzRJEZMrRFOOrMSZyPIAZiaoy0e5BMaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjn/BMM9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjn/BMM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784023761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmYNaA+5oKQvi2MwU3Go0Jq3d3s0gwtHKKIHEJ19AnU=;
	b=fjn/BMM9x6RQQGMfA2f9HGpZj1DlwxWaglASyM6hlrshmAZ9GSCVkjG0aiNvDLtNFShiby
	Utb/nCA+1Jv0ccUMmMUZwNSHQqUc94LTrleYLEyxQI3kdUteRmAi+PJfjfi1UZ3RMvvgYr
	UnPaek0780nbY0K413I+8PiTYZ9D3sQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-QxCFutWdMkyQ192Lumsu-g-1; Tue,
 14 Jul 2026 06:09:19 -0400
X-MC-Unique: QxCFutWdMkyQ192Lumsu-g-1
X-Mimecast-MFC-AGG-ID: QxCFutWdMkyQ192Lumsu-g_1784023758
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74B6D1956051;
	Tue, 14 Jul 2026 10:09:18 +0000 (UTC)
Received: from localhost (unknown [10.44.32.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79CF31956040;
	Tue, 14 Jul 2026 10:09:17 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,  Christian Brauner
 <brauner@kernel.org>,  linux-erofs@lists.ozlabs.org,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
In-Reply-To: <c812e638-8a66-4dc0-b8d9-c971134bb413@linux.alibaba.com> (Gao
	Xiang's message of "Tue, 14 Jul 2026 14:45:09 +0800")
References: <20260711071137.4130824-1-gscrivan@redhat.com>
	<2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
	<871pd748kh.fsf@redhat.com>
	<2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
	<87wluz2nnc.fsf@redhat.com>
	<2026-07-14-drafty-folded-woes-volumes-Z93P4V@cyphar.com>
	<ba9cf493-45c8-45e8-9e21-9731ec492030@linux.alibaba.com>
	<87pl0q2i2r.fsf@redhat.com>
	<c812e638-8a66-4dc0-b8d9-c971134bb413@linux.alibaba.com>
Date: Tue, 14 Jul 2026 12:09:15 +0200
Message-ID: <87ldbd3mt0.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Gao Xiang <hsiangkao@linux.alibaba.com> writes:

> On 2026/7/14 14:36, Giuseppe Scrivano wrote:
>> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
>> 
>>> On 2026/7/14 08:49, Aleksa Sarai wrote:
>>>> On 2026-07-13, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>>>> thanks for the hints.
>>>>>
>>>>> I'll prepare a v3 if you are fine with the version below:
>>>> No worries, and this seems more reasonable at a first glance.
>>>>
>>>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>>>> index 86fa5c6a0c70..72c85cc53085 100644
>>>>> --- a/fs/erofs/super.c
>>>>> +++ b/fs/erofs/super.c
>>>> ...
>>>>> @@ -437,6 +439,38 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>>>>>    	return false;
>>>>>    }
>>>>>    +static int erofs_fc_parse_source(struct fs_context *fc,
>>>>> +				 struct fs_parameter *param)
>>>>> +{
>>>>> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>>>>> +
>>>>> +	if (fc->source || sbi->dif0.file)
>>>>> +		return invalf(fc, "Multiple sources");
>>>>> +
>>>>> +	switch (param->type) {
>>>>> +	case fs_value_is_string:
>>>>> +		fc->source = param->string;
>>>>> +		param->string = NULL;
>>>>> +		return 0;
>>>>> +	case fs_value_is_file: {
>>>>> +		char *buf, *p;
>>>>> +
>>>>> +		sbi->dif0.file = get_file(param->file);
>>>> A very minor nit, but you can actually steal the file reference here
>>>> with
>>>> 		sbi->dif0.file = no_free_ptr(param->file);
>>>> A few other places do this. (You'll also need to change the
>>>> param->file
>>>> reference below.)
>>>>
>>>>> +		buf = kmalloc(PATH_MAX, GFP_KERNEL);
>>>>> +		if (!buf)
>>>>> +			return -ENOMEM;
>>>>> +		p = file_path(param->file, buf, PATH_MAX);
>>>>> +		fc->source = kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
>>>> I think that /proc/self/fd/%d would be a more useful name for
>>>> debugging
>>>> if file_path() fails (not that it is really possible here AFAICS). But
>>>> I'm not really too fussed.
>>>
>>> Not quite sure if we should get in agreement with the format of this
>>> one in advance (IOWs, users use source_fd and how fc->source looks like;
>>> since other fses may follow the same practice if source_fd becomes common
>>> later) since it's a user-visible field and I believe we shouldn't treat
>>> this one as a dontcare field as some pseudo fses (since those fses don't
>>> rely on `fc->source` by design but typically EROFS can rely on.)
>>>
>>> I hope Christian and others could share move thought on this part too
>>> before I land this feature for the next cycle.
>> would it be better to just return the error from file_path without
>> any
>> fallback?
>
> I hope Christian or other vfs folks can decide how to handle fc->source
> string here, since in the long term, how to deal with source_fd should
> be unique among different fses: just our current short-term
> implementation lands into erofs directly for file-backed mounts to
> fulfill composefs needs.
>

overlayfs is already handling such a case, and it resolves the path using d_path:

static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
			   enum ovl_opt layer)
{
	struct path layer_path __free(path_put) = {};
	int err = 0;

	switch (param->type) {
	case fs_value_is_string:
		err = ovl_kern_path(param->string, &layer_path, layer);
		if (err)
			return err;
		err = ovl_do_parse_layer(fc, param->string, &layer_path, layer);
		break;
	case fs_value_is_file: {
		char *buf __free(kfree);
		char *layer_name;

		buf = kmalloc(PATH_MAX, GFP_KERNEL_ACCOUNT);
		if (!buf)
			return -ENOMEM;

		layer_path = param->file->f_path;
		path_get(&layer_path);

		layer_name = d_path(&layer_path, buf, PATH_MAX);
		if (IS_ERR(layer_name))
			return PTR_ERR(layer_name);

		err = ovl_do_parse_layer(fc, layer_name, &layer_path, layer);
		break;
	}
	default:
		WARN_ON_ONCE(true);
		err = -EINVAL;
	}

	return err;
}

If there are no objections, I'll change the code to match what overlay
does and return the error instead of using a fallback.

Regards,
Giuseppe

